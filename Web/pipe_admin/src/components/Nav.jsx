import styled from "styled-components";
import { Link } from 'react-router-dom';
import React from 'react';
import './Nav.css';

// const Navigation = styled.nav`
//   min-width: 200px;
//   padding-right: 20px;
// `;

// function Nav({ children }) {
//   return <Navigation>{children}</Navigation>;
// }

function Nav(){
    return (
        <div>
            <div classNAme="navBar">
                <Link className="navBarMenu" to={'/money'}>돈</Link>
                <Link className="navBarMenu" to={'/place'}>공간</Link>
                <Link className="navBarMenu" to={'/job'}>취업</Link>
                <Link className="navBarMenu" to={'/insure'}>보험</Link>
                <Link className="navBarMenu" to={'/etc'}>미확장</Link>
            </div>
        </div>
    )
}
export default Nav;