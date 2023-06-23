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

  const toggle = () => setModal(!modal)

  const handleRegister = () => {
    console.log('Registering in progress..', newStudent)
    registerStudent(newStudent)
      .then((response) => {
        console.log(response.data)
        toggle()
        setSuccessRegister(true)
      })
      .catch((error) => {
        console.error('error', error)
        setErrorRegister(error.response.data.message || error.message || 'Error')
      })
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
              />
            </FormGroup>
            <FormGroup>
              <Label for="Email">Email</Label>
              <Input
                id="email"
                name="email"
                placeholder="Student email"
                type="email"
                value={newStudent.email}
                onChange={(e) => setNewStudent({ ...newStudent, email: e.target.value })}
              />
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
              />
            </FormGroup>
          </Form>
        </ModalBody>
        <ModalFooter>
          <Button onClick={handleRegister}>Register</Button>
          <Button outline onClick={toggle}>
            Cancel
          </Button>
        </ModalFooter>
      </Modal>
    </>
  )
}

export default RegisterBtn
