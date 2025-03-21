import { Link } from 'react-router-dom';
import React from 'react';
import './Nav.css';

function Nav(){
    return (
        <div className='wrapper'>
            <div className="navBar">
                <Link className="navBarMenu" to={'/'}>Home</Link>
                <Link className="navBarMenu" to={'/notification'}>공지사항</Link>
                <Link className="navBarMenu" to={'/money'}>돈</Link>
                <Link className="navBarMenu" to={'/place'}>공간</Link>
                <Link className="navBarMenu" to={'/job'}>취업</Link>
                <Link className="navBarMenu" to={'/insurance'}>보험</Link>
            </div>
        </div>
    )
}
export default Nav;