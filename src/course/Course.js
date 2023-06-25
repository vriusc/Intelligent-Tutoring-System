import { Navigate, useLoaderData } from 'react-router-dom'
import { getStudent, getUnitsBySubjectId } from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from '../element/Header'

export async function loader({ params }) {
  const units = await getUnitsBySubjectId(params.courseId)
  return { units }
}

const Course = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const { data } = useLoaderData().units
  console.log('units', data)

  useEffect(() => {
    getStudent(studentId).then((response) => {
      settingStudents(response)
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  return (
    <>
      <Header user={student} subjectCount={1} title="My units" />
      <div className="Course-container">
        <div className="Course"></div>
      </div>
    </>
  )
}

export default Course
