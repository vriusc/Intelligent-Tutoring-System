import './Login.css'
import { Button, Form, Input, Label } from 'reactstrap'
import logo from '../assets/logo-no-background.png'
import { useState } from 'react'

const Login = () => {
  const [loginForm, setLoginForm] = useState({ email: '', password: '' })

  const handleLogIn = () => {
    console.log('Login with', loginForm)
  }

  return (
    <div className="Login-body">
      <img src={logo} className="Login-logo" alt="logo" />
      <Form className="Login-form">
        <Input
          id="email"
          name="email"
          type="email"
          placeholder="Email"
          value={loginForm.email}
          onChange={(e) => setLoginForm({ ...loginForm, email: e.target.value })}
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
        <Button color="secondary" block>
          REGISTER
        </Button>
      </Form>
    </div>
  )
}

export default Login
