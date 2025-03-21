import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import Dropdown from '../../custom/dropdown/Dropdown';
import { initializeApp } from 'firebase/app';
import { getDatabase, ref, push, onValue } from 'firebase/database'; // Corrected import
import 'firebase/database';

const TitleInput = styled.textarea`
  width: 60%;
  height: 20px;
  border: 1px solid #ccc;
  resize: none;
  padding: 10px;
  margin-right: 15px;
  margin-bottom: 15px;
  /* Improved accessibility: Label for association */
  &:before {
    content: 'Notification Title:';
    opacity: 0.5;
    position: absolute;
    top: 10px;
    left: 10px;
  }
`;

const ContentInput = styled.textarea`
  width: 60%;
  height: 50px;
  border: 1px solid #ccc;
  resize: none;
  padding: 10px;
  margin-bottom: 15px;
  /* Improved accessibility: Label for association */
  &:before {
    content: 'Notification Content:';
    opacity: 0.5;
    position: absolute;
    top: 10px;
    left: 10px;
  }
`;

const AddButton = styled.button`
  background-color: #4caf50; /* Green color */
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  margin: 15px 0; /* Adjust margin for spacing */
  height: 50px; /* Set fixed height */
`;


const NotificationList = styled.ul`
  list-style: none;
  padding: 0;
  margin: 0;
`;

const NotificationItem = styled.li`
  display: flex; /* Added for better layout of content and button */
  justify-content: space-between; /* Added for better layout */
  align-items: center; /* Added for better layout */
  padding: 10px;
  border-bottom: 1px solid #ccc;
`;

const firebaseConfig = {
  apiKey: "AIzaSyDWMl0rO9RVAHcI7_4c7AVtMIks-k_v26U",
  authDomain: "pipe-e7fc7.firebaseapp.com",
  databaseURL: "https://pipe-e7fc7-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "pipe-e7fc7",
  storageBucket: "pipe-e7fc7.appspot.com",
  messagingSenderId: "69486911602",
  appId: "1:69486911602:web:08e5e2b61de9acbd5322eb",
  measurementId: "G-8JV4NR20ND"
};
const app = initializeApp(firebaseConfig);
const firebaseDB = getDatabase(app);
const platform = "ios"
const NotifyiOS = () => {
  const [title, setTitle] = useState(''); // Use descriptive state names
  const [content, setContent] = useState('');
  const [country, setCountry] = useState('korea'); // Initialize country state
  const [notifications, setNotifications] = useState([]); // Use a more descriptive name

  
  useEffect(() => {
    const dbRef = ref(firebaseDB, `${country}/${platform}/`);
    onValue(dbRef, (snapshot) => {
      const data = snapshot.val();
      if (data !== null) {
        const notificationArray = Object.keys(data)
          .map((key) => ({
            id: key,
            ...data[key],
          }))
          .sort((a, b) => new Date(b.date) - new Date(a.date)); // 시간 내림차순으로 정렬
        notificationArray.reverse();
        setNotifications(notificationArray);
      } else {
        setNotifications([]);
        console.log('No data available');
      }
    });
  
    return () => {
      // 데이터베이스 연결 해제
    };
  }, [country, firebaseDB]);
  
  


  const handleEditTextChange = (event) => {
    const { name, value } = event.target; // Destructure for clarity
    if (name === 'title') {
      setTitle(value);
    } else if (name === 'content') {
      setContent(value);
    }
  };

  const handleAddNotification = () => {
    if (title.trim()) {
      const formattedDate = new Date().toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      });
      const newNotification = {
        title: title,
        content: content,
        date: formattedDate
      };
      const dbRef = ref(firebaseDB, `${country}/${platform}/`);
      push(dbRef, newNotification);

      setTitle('');
      setContent('');
    }
  };

  const flagList = [
    { emoji: "🇰🇷", title: "korea" },
    { emoji: "🇦🇺", title: "australia" },
    { emoji: "🇪🇸", title: "spain" },
    { emoji: "🇮🇩", title: "indonesia" },
    { emoji: "🇮🇹", title: "italy" },
    { emoji: "🇯🇵", title: "japan" },
    { emoji: "🇫🇷", title: "france" },
  ];
  
  const handleFlagSelected = (selectedOption) => {
    setCountry(selectedOption.title);
    console.log('Selected title:', country);
  };
  
  return (
    <div>
      <div>
        <TitleInput
          name="title" // Added for form association
          value={title}
          onChange={handleEditTextChange}
          placeholder="Enter Notification Title" // Improved placeholder
        />
        <ContentInput
          name="content" // Added for form association
          value={content}
          onChange={handleEditTextChange}
          placeholder="Enter Notification Content" // Improved placeholder
        />
        <Dropdown
          options={flagList}
          onOptionSelect={handleFlagSelected} // Pass the handler function
        />
      </div>
      <AddButton 
        contentHeight={content.length > 0 ? content.split('\n').length * 18 : 50} 
        onClick={handleAddNotification}>
          Add Notification
      </AddButton>
      <NotificationList>
        {notifications.map((notification, index) => (
          <NotificationItem key={index}>
            <div>
              <h3>{notification.title}</h3>
              <p>{notification.content}</p>
              <p>{notification.country}</p>
              <span>Date: {notification.date}</span>
            </div>
          </NotificationItem>
        ))}
      </NotificationList>
    </div>
  );
};

export default NotifyiOS;