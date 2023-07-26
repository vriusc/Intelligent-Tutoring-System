import './History.css'
import { useEffect, useState } from 'react'
import { Navigate, useLoaderData } from 'react-router-dom'
import { getOptions, getQuestionsByUnitId, getStudent, getUnitById } from '../lib/tutoring-client'
import Header from '../element/Header'
import HistoryTable from './HistoryTable'
import Question from '../question/Question'

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
  const [optionsList, setOptionsList] = useState([])

  const { data: unit } = useLoaderData().unit

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getQuestionsByUnitId(unit.unitId),
      getOptions({ size: 1000 })
    ]).then((response) => {
      console.log('Student, Questions, Options', response)
      settingStudents(response[0])
      settingQuestions(response[1])
      settingOptions(response[2])
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

  const settingOptions = (response) => {
    const { content } = response.data
    if (content) {
      setOptionsList(content)
    }
  }

  const myOptions = (thisOptions, questionId) => {
    return [...thisOptions.filter((option) => option.questionId === questionId)]
  }

  const findCorrectOption = (questionId) => {
    const optionSelected = optionsList.find(
      (option) => option.questionId === questionId && option.isCorrect === 1
    )
    return optionSelected.optionId
  }

  const findGroupOptions = (questionId) => {
    const optionsSelected = optionsList.filter(
      (option) => option.questionId === questionId && option.isCorrect === 1
    )
    return [...optionsSelected.map((opt) => opt.optionId)]
  }

  return (
    <>
      <Header user={student} subjectCount={1} title={unit.unitName} />
      <div className="History-container">
        <div className="History">
          <h3 className="mb-5">{`${unit.unitName}: History`}</h3>
          {questionList.map((question, index) => (
            <div key={index} className="mb-5">
              <h5>{`${index + 1}. ${question.questions.question}`}</h5>
              <h6>Table:</h6>
              <HistoryTable studentId={studentId} questionId={question.questionId} />
              <h6>Question:</h6>
              <Question
                question={question}
                options={myOptions(optionsList, question.questionId)}
                number={index + 1}
                disabled
                radioSelected={
                  question.questions.questionTypeId < 6
                    ? findCorrectOption(question.questionId)
                    : null
                }
                multiSelected={
                  question.questions.questionTypeId >= 6
                    ? findGroupOptions(question.questionId)
                    : []
                }
              />
            </div>
          ))}
        </div>
      </div>
    </>
  )
}

export default History
