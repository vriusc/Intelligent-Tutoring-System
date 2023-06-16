import { Button, Form, Input, Label } from "reactstrap"
import logo from './assets/logo-no-background.png'

const Login = () => {
  return (
    <div className="Login-body">
      <img src={logo} className="Login-logo" alt="logo" />
      <Form className="Login-form">
        <Input 
          id="email"
          name="email"
          type="email"
          placeholder="Email"
        />

        <Input 
          id="passwrod"
          name="password"
          type="password"
          placeholder="Password"
        />
        <Button color="secondary" block>LOG IN</Button>
        <Label style={{ marginTop: '20px' }}>Or</Label>
        <Button color="secondary" block>REGISTER</Button>
      </Form>
    </div>
  )
}

export default Login