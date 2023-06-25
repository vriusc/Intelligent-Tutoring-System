import './Unit.css'
import { Navigate, useLoaderData } from 'react-router-dom'
import { getOptions, getQuestionsByUnitId, getStudent, getUnitById } from '../lib/tutoring-client'
import Header from '../element/Header'
import { useEffect, useState } from 'react'
import YoutubePlater from './YoutubePlayer'
import { Badge, Button } from 'reactstrap'
import Question from './Question'

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
  const [questions, setQuestions] = useState({})
  const [questOptions, setQuestOptions] = useState([])
  const [showQuestions, setShowQuestions] = useState(false)

  useEffect(() => {
    Promise.all([getStudent(studentId), getOptions({})]).then((response) => {
      console.log(response)
      settingStudents(response[0])
      settingOptions(response[1])
    })
  }, [studentId])
  const { data } = useLoaderData().unit

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingOptions = (response) => {
    const { content } = response.data
    if (content) {
      setQuestOptions(content)
    }
  }

  const goToQuestions = () => {
    getQuestionsByUnitId(data.unitId).then((response) => {
      setQuestions(response.data.content)
      setShowQuestions(true)
    })
  }

  const myOptions = (thisOptions, questionId) => {
    return [...thisOptions.filter((option) => option.questionId === questionId)]
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
          <Button
            color="success"
            className="Unit-btn-quest"
            hidden={showQuestions}
            onClick={() => goToQuestions()}
          >
            Go to questions
          </Button>
          {showQuestions && (
            <>
              {questions.length > 0 && <h4 className="mt-5">Questions</h4>}
              {questions.map((question, index) => (
                <Question
                  key={question.questionId}
                  question={question}
                  options={myOptions(questOptions, question.questionId)}
                  number={index + 1}
                />
              ))}
              {questions.length === 0 && (
                <h3 style={{ alignSelf: 'center', marginTop: '2em' }}>
                  <Badge color="info">Sorry we are creating the questions for this unit</Badge>
                </h3>
              )}
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default Unit
