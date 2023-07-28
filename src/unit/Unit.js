import './Unit.css'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import {
  getOptions,
  getQuestionsByUnitId,
  getStudent,
  getStudentUnit,
  getUnitById,
  postRecord,
  postStudentUnit,
  putStudentUnit
} from '../lib/tutoring-client'
import Header from '../element/Header'
import { useEffect, useState } from 'react'
import YoutubePlater from './YoutubePlayer'
import { Badge, Button, Card, CardBody, CardText } from 'reactstrap'
import Question from '../question/Question'
import { gptResponse } from '../lib/gpt-client'

export async function loader({ params }) {
  const unit = await getUnitById(params.unitId)
  return { unit, studentSubjectId: params.courseId }
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
  const [onReview, setOnReview] = useState(false)
  const [answersList, setAnswersList] = useState([])
  const [gptFeedback, setGPTFeedback] = useState('')
  const [studentUnit, setStudentUnit] = useState({})

  const navigate = useNavigate()
  const { data } = useLoaderData().unit
  const studentSubjectId = useLoaderData().studentSubjectId

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getOptions({ size: 1000 }),
      getStudentUnit({ studentId, unitId: data.unitId })
    ]).then((response) => {
      console.log('Student, Options, Student-unit', response)
      settingStudents(response[0])
      settingOptions(response[1])
      settingStudentUnit(response[2])
    })
  }, [studentId])

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

  const settingStudentUnit = (response) => {
    const { content } = response.data
    if (content && content.length) {
      endPage(content[0], true)
    } else {
      setStudentUnit({ studentId, unitId: data.unitId, isfinished: 0 })
    }
  }

  const goToQuestions = () => {
    getQuestionsByUnitId(data.unitId).then((response) => {
      const data = response.data.content
      console.log('Questions', data)
      setQuestions(data)
      setShowQuestions(true)
      createAnswerList(data)
    })
  }

  const myOptions = (thisOptions, questionId) => {
    return [...thisOptions.filter((option) => option.questionId === questionId)]
  }

  const reviewQuestions = async () => {
    try {
      setOnReview(true)
      const recordList = []
      const newAnswerList = answersList.map((myQuest) => {
        const { studentId, questionId } = myQuest
        const toRecord = myQuest.myOptions.map((myOpt) => ({
          studentId,
          questionId,
          optionId: myOpt.optionId
        }))
        recordList.push(...toRecord)
        myQuest.isCorrect = checkCorrectQuest(myQuest)
        return myQuest
      })
      setAnswersList(newAnswerList)
      console.log('review final:', newAnswerList, recordList)

      // POSTING questions
      for (const record of recordList) {
        await postRecord(record)
        console.log('Question posted', record)
      }
      if (studentUnit.isfinished !== 1) {
        lastAnswerReview()
      }
    } catch (error) {
      console.error(error)
    }
  }

  const resetQuestions = () => {
    setOnReview(false)
    setAnswersList(answersList.map((answer) => ({ ...answer, myOptions: [] })))
  }

  const getFeedback = () => {
    const params = {
      username: student.username,
      test_score: '8',
      text: 'aaa'
    }

    gptResponse(params)
      .then((response) => {
        console.log(response)
        setGPTFeedback(response.data)
      })
      .catch((error) => {
        console.error(error.message)
      })
  }

  const createAnswerList = (list) => {
    const newAnswerList = list.map((quest) => {
      const options = myOptions(questOptions, quest.questionId).filter((opt) => opt.isCorrect)
      return {
        studentId,
        questionId: quest.questionId,
        isCorrect: false,
        correctOptions: options,
        myOptions: []
      }
    })
    setAnswersList(newAnswerList)
  }

  const checkCorrectQuest = (quest) => {
    if (quest.myOptions.length > 0) {
      const allCorrect = !quest.myOptions.some((opt) => opt.isCorrect !== 1)
      return allCorrect && quest.myOptions.length === quest.correctOptions.length
    } else {
      return quest.isCorrect
    }
  }

  const lastAnswerReview = () => {
    // TODO getting answer in progress
    const newStudentUnit = {
      ...studentUnit,
      isfinished: answersList.some((answer) => !answer.isCorrect) ? 0 : 1
    }
    setStudentUnit(newStudentUnit)
    if (newStudentUnit.studentUnitId) {
      const { studentUnitId, isfinished } = newStudentUnit
      putStudentUnit({ studentUnitId, isfinished }).then((response) => {
        const { data } = response
        endPage(data)
      })
    } else {
      postStudentUnit(studentUnit).then((response) => {
        const { data } = response
        endPage(data)
      })
    }
  }

  const endPage = (dataStUnit, firstLoad = false) => {
    setStudentUnit(dataStUnit)
    if (dataStUnit.isfinished === 1 && !firstLoad) {
      navigate(`/courses/${studentSubjectId}`)
    }
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
            {/* <iframe width="420" height="315" src={data.materials_path}></iframe> */}
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
                  review={onReview}
                  answersList={answersList}
                  setAnswersList={setAnswersList}
                  disabled={onReview}
                />
              ))}
              {questions.length === 0 && (
                <h3 style={{ alignSelf: 'center', marginTop: '2em' }}>
                  <Badge color="info">Sorry we are creating the questions for this unit</Badge>
                </h3>
              )}
              <div className="Btn-row">
                <Button
                  disabled={!onReview}
                  className="Unit-btn"
                  color="danger"
                  onClick={() => resetQuestions()}
                >
                  Restart
                </Button>
                <Button
                  className="Unit-btn"
                  color="success"
                  disabled={onReview || questions.length === 0}
                  onClick={() => reviewQuestions()}
                >
                  Submit
                </Button>
                <Button
                  disabled={false}
                  className="Unit-btn"
                  color="primary"
                  onClick={() => getFeedback()}
                >
                  Feedback
                </Button>
              </div>
              {gptFeedback && (
                <Card style={{ marginTop: '1em' }}>
                  <CardBody>
                    <CardText>{gptFeedback}</CardText>
                  </CardBody>
                </Card>
              )}
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default Unit
