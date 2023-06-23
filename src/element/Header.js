import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Collapse,
  Nav,
  NavItem,
  NavLink,
  Navbar,
  NavbarBrand,
  NavbarText,
  NavbarToggler
} from 'reactstrap'

const Header = (student) => {
  const { user } = student
  const [collapsed, setCollapsed] = useState(true)
  const navigate = useNavigate()

  const toggleNavbar = () => setCollapsed(!collapsed)

  const handleLogout = () => {
    localStorage.clear()
    navigate('/login')
  }

  return (
    <Navbar color="dark" dark>
      <NavbarBrand className="me-auto" href="/">
        Intelligent Tutoring System
      </NavbarBrand>
      <NavbarText className="me-2">Welcome {user.username}</NavbarText>
      <NavbarToggler className="me-2" onClick={toggleNavbar} />
      <Collapse isOpen={!collapsed} navbar>
        <Nav navbar>
          <NavItem>
            <NavLink href="#">Reset Password</NavLink>
          </NavItem>
          <NavItem>
            <NavLink href="#" onClick={handleLogout}>
              LOG OUT
            </NavLink>
          </NavItem>
        </Nav>
      </Collapse>
    </Navbar>
  )
}

export default Header
