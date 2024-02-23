import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Nav from './components/Nav';

<Link className="navBarMenu" to={'/money'}>돈</Link>
<Link className="navBarMenu" to={'/place'}>공간</Link>
<Link className="navBarMenu" to={'/job'}>취업</Link>
<Link className="navBarMenu" to={'/insure'}>보험</Link>
<Link className="navBarMenu" to={'/etc'}>미확장</Link>
const App = ( ) => {
  // return (
  //   <div>
  //     React Admin Project
  //   </div>
  // );
  return (
    <BrowserRouter>
      <div className="App">
        <Header />
        <Nav />
        <Routes>
          <Route path="/money" element= { <Money />}/>
          <Route path="/" element= { <money />}/>
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
