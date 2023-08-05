import './Login.css'
import { Alert, Button, Input } from 'reactstrap'
import logo from '../assets/logo-no-background.png'
import { useState } from 'react'
import { getSubjectsById, loginStudent } from '../lib/tutoring-client'
import { useNavigate } from 'react-router-dom'
import RegisterBtn from './Register'
import LanguageSelector from '../Language'
import { useTranslation } from 'react-i18next'

const Login = () => {
  const [loginForm, setLoginForm] = useState({ usernameOrEmail: '', password: '' })
  const [errorMessage, setErrorMessage] = useState()

  const navigate = useNavigate()
  const { t } = useTranslation()

  const handleLogIn = () => {
    const result = loginStudent(loginForm)
    result
      .then((response) => {
        console.log('result', response.data)
        localStorage.setItem('studentId', response.data.studentId)
        getSubjectsById(response.data.studentId).then((response) => {
          const { data } = response
          if (data && data.length > 0) {
            navigate(`/courses`)
          } else {
            navigate('/')
          }
        })
      })
      .catch((error) => {
        console.error(error.message)
        setErrorMessage(error.response.data.message || error.message || 'Error')
        setTimeout(() => {
          setErrorMessage('')
        }, 5000)
      })
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
          placeholder={t('username_or_email')}
          value={loginForm.email}
          onChange={(e) => setLoginForm({ ...loginForm, usernameOrEmail: e.target.value })}
        />

        <Input
          id="passwrod"
          name="password"
          type="password"
          placeholder={t('password')}
          value={loginForm.password}
          onChange={(e) => setLoginForm({ ...loginForm, password: e.target.value })}
        />
        <Button color="secondary" block onClick={handleLogIn}>
          {t('log_in')}
        </Button>
        <RegisterBtn />
        <div style={{ marginTop: '15px' }}>
          <LanguageSelector />
        </div>
      </div>
    </div>
  )
}

export default Login
