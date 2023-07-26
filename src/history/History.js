import './History.css'
import { useEffect, useState } from 'react'
import { Navigate, useLoaderData } from 'react-router-dom'
import { getQuestionsByUnitId, getStudent, getUnitById } from '../lib/tutoring-client'
import Header from '../element/Header'

export async function loader({ params }) {
  const { courseId: studentSubjectId, unitId } = params
  const unit = await getUnitById(unitId)
  return { unit, studentSubjectId }
}

const History = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }

  const [student, setStudent] = useState({})
  const [questionList, setQuestionList] = useState([])

  const { data: unit } = useLoaderData().unit

  useEffect(() => {
    Promise.all([getStudent(studentId), getQuestionsByUnitId(unit.unitId)]).then((response) => {
      console.log('Student, Questions', response)
      settingStudents(response[0])
      settingQuestions(response[1])
    })
  }, [])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingQuestions = (response) => {
    const { content } = response.data
    setQuestionList(content)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title={unit.unitName} />
      <div className="History-container">
        <div className="History">
          <h3>{`${unit.unitName}: History`}</h3>
          {questionList.map((question, index) => (
            <div key={index}>
              <div>{index + 1}</div>
              <div>{question.questions.question}</div>
            </div>
          ))}
        </div>
      </div>
    </>
  )
}

export default History
