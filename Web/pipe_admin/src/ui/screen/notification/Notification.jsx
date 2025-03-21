import TabLayout from '../../custom/tablayout/TabLayout';
import NotifyAndroid from './NotifyAndroid';
import NotifyiOS from './NotifyiOS';
import NotifyWeb from './NotifyWeb';


const Notification = () => {
  const menuArr = [
    { name: 'NotifyWeb', view: <NotifyWeb/> },
    { name: 'NotifyAndroid', view: <NotifyAndroid/> }, 
    { name: 'NotifyiOS', view: <NotifyiOS/> }
  ];
  return (
    <div className="Notification">
       <TabLayout menuArr={menuArr} />
    </div>
  );
};

export default Notification;
