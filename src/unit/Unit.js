import './Unit.css'
import { Navigate, useLoaderData } from 'react-router-dom'
import { getStudent, getUnitById } from '../lib/tutoring-client'
import Header from '../element/Header'
import { useEffect, useState } from 'react'
import YoutubePlater from './YoutubePlayer'
import { Button } from 'reactstrap'

export async function loader({ params }) {
  const unit = await getUnitById(params.unitId)
  return { unit }
}

const Unit = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  // const [questions, setQuestions] = useState({})

  useEffect(() => {
    getStudent(studentId).then((response) => {
      settingStudents(response)
    })
  }, [studentId])
  const { data } = useLoaderData().unit

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const goToQuestions = () => {
    console.log('questions')
  }

  return (
    <>
      <Header user={student} subjectCount={1} title={data.unitName} />
      <div className="Unit-container">
        <div className="Unit Unit-flex">
          <h3 className="mb-4">Unit Lesson</h3>
          <h5>Description</h5>
          <p>{data.description}</p>
          <div className="Unit-video">
            <YoutubePlater urlPath={data.materials_path} />
          </div>
          <Button color="success" className="Unit-btn-quest" onClick={() => goToQuestions}>
            Go to questions
          </Button>
        </div>
      </div>
    </>
  )
}

export default Unit
