import './Login.css'
import { Alert, Button, Input, Label } from 'reactstrap'
import logo from '../assets/logo-no-background.png'
import { useState } from 'react'
import { loginStudent } from '../lib/tutoring-client'
import { useNavigate } from 'react-router-dom'

const Login = () => {
  const [loginForm, setLoginForm] = useState({ usernameOrEmail: '', password: '' })
  const [errorMessage, setErrorMessage] = useState()
  const navigate = useNavigate()

  const handleLogIn = () => {
    const result = loginStudent(loginForm)
    result
      .then((response) => {
        console.log('result', response.data)
        localStorage.setItem('studentId', response.data.studentId)
        navigate('/')
      })
      .catch((error) => {
        console.error('error', error.message)
        setErrorMessage(error.response.data.message || error.message || 'Error')
      })
  }

  const registerStudent = () => {
    localStorage.clear()
  }

  return (
    <div className="Login-body">
      <img src={logo} className="Login-logo" alt="logo" />
      <Alert
        className="Alert-error"
        color="danger"
        isOpen={!!errorMessage}
        toggle={() => setErrorMessage('')}
      >
        {errorMessage}
      </Alert>
      <div className="Login-form">
        <Input
          id="username"
          name="usernameOrEmail"
          type="text"
          placeholder="Username or Email"
          value={loginForm.email}
          onChange={(e) => setLoginForm({ ...loginForm, usernameOrEmail: e.target.value })}
        />

        <Input
          id="passwrod"
          name="password"
          type="password"
          placeholder="Password"
          value={loginForm.password}
          onChange={(e) => setLoginForm({ ...loginForm, password: e.target.value })}
        />
        <Button color="secondary" block onClick={handleLogIn}>
          LOG IN
        </Button>
        <Label style={{ marginTop: '20px' }}>Or</Label>
        <Button color="secondary" block onClick={registerStudent}>
          REGISTER
        </Button>
      </div>
    </div>
  )
}

export default Login
