import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Alert,
  Button,
  Collapse,
  Form,
  FormGroup,
  Input,
  Label,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader,
  Nav,
  NavItem,
  NavLink,
  Navbar,
  NavbarBrand,
  NavbarText,
  NavbarToggler
} from 'reactstrap'
import { updatePassword } from '../lib/tutoring-client'
import { useTranslation } from 'react-i18next'
import LanguageSelector from '../Language'

const Header = (student) => {
  const { user, subjectCount, title } = student
  const navigate = useNavigate()
  const { t } = useTranslation()
  const [collapsed, setCollapsed] = useState(true)
  const [resetPass, setResetPass] = useState(false)
  const [updatePass, setUpdatePass] = useState({
    username: '',
    email: '',
    currentPassword: '',
    newPassword: ''
  })
  const [updateError, setUpdateError] = useState()

  const toggleNavbar = () => setCollapsed(!collapsed)
  const toggleModal = () => setResetPass(!resetPass)

  const handleLogout = () => {
    localStorage.clear()
    navigate('/login')
  }

  const handleResetPass = () => {
    setUpdatePass({ ...updatePass, username: user.username, email: user.email })
    toggleModal()
  }

  const handleModalCancel = () => {
    setUpdatePass({
      username: '',
      email: '',
      currentPassword: '',
      newPassword: ''
    })
    toggleModal()
  }

  const handleUpdate = () => {
    updatePassword(updatePass)
      .then((response) => {
        console.log(response.data)

        toggleNavbar()
        handleModalCancel()
      })
      .catch((error) => {
        console.error(error)
        setUpdateError(error.response.data || error.message || 'Error')
      })
  }

  return (
    <>
      <Navbar color="dark" dark>
        <NavbarBrand
          className={title ? 'me-2' : 'me-auto'}
          href={subjectCount > 0 ? '/courses' : '/'}
        >
          {t('its_title')}
        </NavbarBrand>
        <NavbarText className="me-auto" hidden={!title}>{` - ${title}`}</NavbarText>
        <NavbarText className="me-2">{`${t('hello')} ${user.username}`}</NavbarText>
        <NavbarText className="me-3">
          <LanguageSelector />
        </NavbarText>
        <NavbarToggler className="me-2" onClick={toggleNavbar} />
        <Collapse isOpen={!collapsed} navbar>
          <Nav navbar>
            <NavItem hidden={subjectCount === 0 || subjectCount === null}>
              <NavLink href="#" onClick={() => navigate('/courses')}>
                {t('my_courses')}
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink href="#" onClick={() => navigate('/writingTest')}>
                {t('writing_test')}
              </NavLink>
            </NavItem>
            <NavItem hidden={subjectCount === 0 || subjectCount === null}>
              <NavLink href="#" onClick={() => navigate('/questionnaire')}>
                {t('learning_style_quest')}
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink href="#" onClick={handleResetPass}>
                {t('reset_password')}
              </NavLink>
            </NavItem>
            <NavItem>
              <NavLink href="#" onClick={handleLogout}>
                {t('log_out')}
              </NavLink>
            </NavItem>
          </Nav>
        </Collapse>
      </Navbar>
      <Modal isOpen={resetPass} toggle={handleModalCancel}>
        <ModalHeader toggle={handleModalCancel}>{t('reset_password')}</ModalHeader>
        <ModalBody>
          <Alert color="danger" isOpen={!!updateError} toggle={() => setUpdateError('')}>
            {updateError}
          </Alert>
          <Form>
            <FormGroup>
              <Label for="resetUsername">{t('username')}</Label>
              <Input
                id="resetUsername"
                name="username"
                placeholder="Username"
                value={updatePass.username}
                disabled
              />
            </FormGroup>
            <FormGroup>
              <Label for="resetEmail">{t('email')}</Label>
              <Input
                id="resetEmail"
                name="email"
                placeholder="Email"
                type="email"
                value={updatePass.email}
                disabled
              />
            </FormGroup>
            <FormGroup>
              <Label for="currentPassword">{t('current_password')}</Label>
              <Input
                id="currentPassword"
                name="password"
                placeholder="Current password"
                type="password"
                value={updatePass.currentPassword}
                onChange={(e) => setUpdatePass({ ...updatePass, currentPassword: e.target.value })}
              />
            </FormGroup>
            <FormGroup>
              <Label for="newPassword">{t('new_password')}</Label>
              <Input
                id="newPassword"
                name="password"
                placeholder="New password"
                type="password"
                value={updatePass.newPassword}
                onChange={(e) => setUpdatePass({ ...updatePass, newPassword: e.target.value })}
              />
            </FormGroup>
          </Form>
        </ModalBody>
        <ModalFooter>
          <Button onClick={handleUpdate}>{t('update_password')}</Button>
          <Button outline onClick={handleModalCancel}>
            {t('cancel')}
          </Button>
        </ModalFooter>
      </Modal>
    </>
  )
}

export default Header
