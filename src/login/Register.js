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

const RegisterBtn = () => {
  const [newStudent, setNewStudent] = useState({ username: '', email: '', password: '' })
  const [modal, setModal] = useState(false)
  const [errorRegister, setErrorRegister] = useState()
  const [successRegister, setSuccessRegister] = useState(false)
  const [isUsernameValid, setIsUsernameValid] = useState(true)
  const [isEmailValid, setIsEmailValid] = useState(true)
  const [isPassValid, setIsPassValid] = useState(true)

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
        REGISTER
      </Button>
      <Alert className="Success-register" color="success" isOpen={successRegister}>
        Student registered successfully
      </Alert>
      <Modal isOpen={modal} toggle={toggle}>
        <ModalHeader toggle={toggle}>Student registration</ModalHeader>
        <ModalBody>
          <Alert color="danger" isOpen={!!errorRegister} toggle={() => setErrorRegister('')}>
            {errorRegister}
          </Alert>
          <Form>
            <FormGroup>
              <Label for="username">Username</Label>
              <Input
                id="username"
                name="username"
                placeholder="Unique username"
                value={newStudent.username}
                onChange={(e) => setNewStudent({ ...newStudent, username: e.target.value })}
                onBlur={(e) => usernameValidation(e.target.value)}
                required
              />
              {!isUsernameValid && (
                <Alert color="danger" className="Register-validation">
                  Enter a valid username, please.
                </Alert>
              )}
            </FormGroup>
            <FormGroup>
              <Label for="email">Email</Label>
              <Input
                id="email"
                name="email"
                placeholder="Student email"
                type="email"
                value={newStudent.email}
                onChange={(e) => setNewStudent({ ...newStudent, email: e.target.value })}
                onBlur={(e) => emailValidation(e.target.value)}
                required
              />
              {!isEmailValid && (
                <Alert color="danger" className="Register-validation">
                  Enter a valid email, please.
                </Alert>
              )}
            </FormGroup>
            <FormGroup>
              <Label for="password">Password</Label>
              <Input
                id="password"
                name="password"
                placeholder="Password"
                type="password"
                value={newStudent.password}
                onChange={(e) => setNewStudent({ ...newStudent, password: e.target.value })}
                onBlur={(e) => passwordValidation(e.target.value)}
              />
              {!isPassValid && (
                <Alert color="warning" className="Register-validation">
                  <p>Password needs:</p>
                  <ul>
                    <li>At least one lowercase letter.</li>
                    <li>At least one uppercase letter.</li>
                    <li>At least one digit.</li>
                    <li>Minimum length of 8 characters.</li>
                  </ul>
                </Alert>
              )}
            </FormGroup>
          </Form>
        </ModalBody>
        <ModalFooter>
          <Button disabled={disableButton()} onClick={handleRegister}>
            Register
          </Button>
          <Button outline onClick={handleCancel}>
            Cancel
          </Button>
        </ModalFooter>
      </Modal>
    </>
  )
}

export default RegisterBtn
