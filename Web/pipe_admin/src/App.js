import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Nav from './ui/custom/nav/Nav';
import Home from './ui/screen/Home';
import Notification from './ui/screen/notification/Notification';
import Money from './ui/screen/Money';
import Place from './ui/screen/Place';
import Job from './ui/screen/Job';
import Insurance from './ui/screen/Insurance'; 

const App = ( ) => {
  return (
    <BrowserRouter>
      <div className="App">
        <Nav/>
        <Routes>
          <Route path="/" element= { <Home />}/>
          <Route path="/notification" element= { <Notification />} />
          <Route path="/money" element= { <Money />} />
          <Route path="/place" element= { <Place />} />
          <Route path="/job" element= { <Job />} />
          <Route path="/insurance" element= { <Insurance />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
};

export default App;

// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;
