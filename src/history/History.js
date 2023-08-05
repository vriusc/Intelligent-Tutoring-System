import './History.css'
import { useEffect, useState } from 'react'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import { getOptions, getQuestionsByUnitId, getStudent, getUnitById } from '../lib/tutoring-client'
import Header from '../element/Header'
import HistoryTable from './HistoryTable'
import Question from '../question/Question'
import { styled } from 'styled-components'
import { Button } from 'reactstrap'
import { useTranslation } from 'react-i18next'

const TitleComponent = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  margin-bottom: 24px;
`

export async function loader({ params }) {
  const { courseId: studentSubjectId, unitId } = params
  const unit = await getUnitById(unitId)
  return { unit, studentSubjectId }
}

const History = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  const { t } = useTranslation()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }

  const [student, setStudent] = useState({})
  const [questionList, setQuestionList] = useState([])
  const [optionsList, setOptionsList] = useState([])

  const { data: unit } = useLoaderData().unit
  const { studentSubjectId } = useLoaderData()

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

  const goToUnit = () => {
    navigate(`/courses/${studentSubjectId}/unit/${unit.unitId}`)
  }

  const goToCourse = () => {
    navigate(`/courses/${studentSubjectId}`)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title={unit.unitName} />
      <div className="History-container">
        <div className="History History-flex">
          <TitleComponent>
            <h3 style={{ alignSelf: 'center' }}>{`${unit.unitName}: ${'history_low'}`}</h3>
            <div>
              <Button style={{ marginRight: '5px' }} color="info" onClick={() => goToCourse()}>
                {t('unit_list')}
              </Button>
              <Button color="success" style={{ alignSelf: 'center' }} onClick={() => goToUnit()}>
                {t('keep_practice')}
              </Button>
            </div>
          </TitleComponent>
          {questionList.map((question, index) => (
            <div key={index} className="mb-5 History-border">
              <h5>{`${index + 1}. ${question.questions.question}`}</h5>
              <h6>Table:</h6>
              <HistoryTable studentId={studentId} questionId={question.questionId} />
              <h6>{`${t('question')}:`}</h6>
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
          <Button
            style={{ marginRight: '5px', alignSelf: 'flex-end' }}
            color="info"
            onClick={() => goToCourse()}
          >
            {t('back_unit_list')}
          </Button>
        </div>
      </div>
    </>
  )
}

export default History
