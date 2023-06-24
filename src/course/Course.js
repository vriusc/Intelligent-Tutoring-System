import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Navigate } from 'react-router-dom'
import { getStudent, getSubjectsById } from '../lib/tutoring-client'

const Course = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [subjects, setSubject] = useState([])

  useEffect(() => {
    Promise.all([getStudent(studentId), getSubjectsById(studentId)]).then((response) => {
      console.log(response)
      settingStudents(response[0])
      settingSubjects(response[1])
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingSubjects = (response) => {
    const { data } = response
    if (data) {
      setSubject(data)
    }
  }

  return (
    <>
      <Header user={student} subjectCount={subjects.length} />
      <div>Testing</div>
    </>
  )
}

export default Course
