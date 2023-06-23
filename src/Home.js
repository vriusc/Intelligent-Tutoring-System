import { Navigate } from 'react-router-dom'
import Header from './element/Header'
import logo from './assets/logo.svg'
import { getStudent } from './lib/tutoring-client'
import { useEffect, useState } from 'react'

const Home = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})

  useEffect(() => {
    getStudent(studentId).then((response) => {
      if (response.data) {
        setStudent(response.data)
      }
    })
  }, [studentId])

  return (
    <>
      <Header user={student} />
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
        </div>
      </div>
    </>
  )
}

export default Home
