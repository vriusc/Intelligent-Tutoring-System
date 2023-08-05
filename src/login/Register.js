import { useState } from 'react'
import {
  Alert,
  Button,
  Form,
  FormGroup,
  Input,
  Label,
  Modal,
  ModalBody,
  ModalFooter,
  ModalHeader
} from 'reactstrap'
import { registerStudent } from '../lib/tutoring-client'
import './Login.css'
import { useTranslation } from 'react-i18next'

const RegisterBtn = () => {
  const [newStudent, setNewStudent] = useState({ username: '', email: '', password: '' })
  const [modal, setModal] = useState(false)
  const [errorRegister, setErrorRegister] = useState()
  const [successRegister, setSuccessRegister] = useState(false)
  const [isUsernameValid, setIsUsernameValid] = useState(true)
  const [isEmailValid, setIsEmailValid] = useState(true)
  const [isPassValid, setIsPassValid] = useState(true)

  const { t } = useTranslation()

  const toggle = () => setModal(!modal)

  const handleRegister = () => {
    setIsUsernameValid(newStudent.username)
    setIsEmailValid(newStudent.email)
    setIsPassValid(newStudent.password)
    if (!disableButton()) {
      registerStudent(newStudent)
        .then((response) => {
          console.log('Success', response.data)
          toggle()
          setSuccessRegister(true)
        })
        .catch((error) => {
          console.error('error', error)
          setErrorRegister(error.response.data.message || error.message || 'Error')
        })
    }
  }

  const handleCancel = () => {
    setNewStudent({ username: '', email: '', password: '' })
    setErrorRegister('')
    setSuccessRegister(false)
    setIsUsernameValid(true)
    setIsEmailValid(true)
    setIsPassValid(true)
    toggle()
  }

  const disableButton = () => {
    return (
      newStudent.username.trim() === '' ||
      newStudent.email.trim() === '' ||
      newStudent.password.trim() === '' ||
      !isUsernameValid ||
      !isEmailValid ||
      !isPassValid
    )
  }

  const usernameValidation = (username) => {
    const usernameRegex = /^[a-zA-Z0-9_-]{4,}$/
    setIsUsernameValid(usernameRegex.test(username))
  }

  const emailValidation = (email) => {
    const emailRegex = /^\S+@\S+\.\S+$/
    setIsEmailValid(emailRegex.test(email))
  }

  const passwordValidation = (password) => {
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/
    setIsPassValid(passwordRegex.test(password))
  }

  return (
    <>
      <Button color="secondary" block onClick={toggle}>
        {t('register')}
      </Button>
      <Alert className="Success-register" color="success" isOpen={successRegister}>
        {t('student_register_success')}
      </Alert>
      <Modal isOpen={modal} toggle={toggle}>
        <ModalHeader toggle={toggle}>{t('student_registration')}</ModalHeader>
        <ModalBody>
          <Alert color="danger" isOpen={!!errorRegister} toggle={() => setErrorRegister('')}>
            {errorRegister}
          </Alert>
          <Form>
            <FormGroup>
              <Label for="username">{t('username')}</Label>
              <Input
                id="username"
                name="username"
                placeholder={t('unique_username')}
                value={newStudent.username}
                onChange={(e) => setNewStudent({ ...newStudent, username: e.target.value })}
                onBlur={(e) => usernameValidation(e.target.value)}
                required
              />
              {!isUsernameValid && (
                <Alert color="danger" className="Register-validation">
                  {t('enter_valid_username')}
                </Alert>
              )}
            </FormGroup>
            <FormGroup>
              <Label for="email">{t('email')}</Label>
              <Input
                id="email"
                name="email"
                placeholder={t('student_email')}
                type="email"
                value={newStudent.email}
                onChange={(e) => setNewStudent({ ...newStudent, email: e.target.value })}
                onBlur={(e) => emailValidation(e.target.value)}
                required
              />
              {!isEmailValid && (
                <Alert color="danger" className="Register-validation">
                  {t('enter_valid_email')}
                </Alert>
              )}
            </FormGroup>
            <FormGroup>
              <Label for="password">{t('password')}</Label>
              <Input
                id="password"
                name="password"
                placeholder={t('password')}
                type="password"
                value={newStudent.password}
                onChange={(e) => setNewStudent({ ...newStudent, password: e.target.value })}
                onBlur={(e) => passwordValidation(e.target.value)}
              />
              {!isPassValid && (
                <Alert color="warning" className="Register-validation">
                  <p>{`${t('password_need')}:`}</p>
                  <ul>
                    <li>{t('one_lowercase')}</li>
                    <li>{t('one_uppercase')}</li>
                    <li>{t('one_digit')}</li>
                    <li>{t('min_8_char')}</li>
                  </ul>
                </Alert>
              )}
            </FormGroup>
          </Form>
        </ModalBody>
        <ModalFooter>
          <Button disabled={disableButton()} onClick={handleRegister}>
            {t('register_low')}
          </Button>
          <Button outline onClick={handleCancel}>
            {t('cancel')}
          </Button>
        </ModalFooter>
      </Modal>
    </>
  )
}

export default RegisterBtn
