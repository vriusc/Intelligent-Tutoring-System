import './Login.css'
import { Button, Input, Label } from 'reactstrap'
import logo from '../assets/logo-no-background.png'
import { useState } from 'react'
import { loginUser } from '../lib/tutoring-client'

const Login = () => {
  const [loginForm, setLoginForm] = useState({ username: '', password: '' })

  const handleLogIn = () => {
    // console.log('Login with', loginForm)
    const result = loginUser(loginForm)
    console.log(result)
  }

  return (
    <div className="Login-body">
      <img src={logo} className="Login-logo" alt="logo" />
      <div className="Login-form">
        <Input
          id="username"
          name="username"
          type="text"
          placeholder="Username"
          value={loginForm.email}
          onChange={(e) => setLoginForm({ ...loginForm, username: e.target.value })}
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
      </div>
    </div>
  )
}

export default Login
