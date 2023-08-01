import './Unit.css'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import {
  getLearningStyle,
  getOptions,
  getQuestionsByUnitId,
  getStudent,
  getStudentUnit,
  getUnitById,
  postRecord
} from '../lib/tutoring-client'
import Header from '../element/Header'
import { useEffect, useState } from 'react'
import YoutubePlater from './YoutubePlayer'
import { Badge, Button } from 'reactstrap'
import Question from '../question/Question'
import ScoreModal from './ScoreModal'

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
  const [studentUnit, setStudentUnit] = useState({})
  const [finished, setFinished] = useState(false)
  const [openModal, setOpenModal] = useState(false)
  const [learningStyle, setLearningStyle] = useState({})

  const navigate = useNavigate()
  const { data } = useLoaderData().unit
  const studentSubjectId = useLoaderData().studentSubjectId

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getOptions({ size: 1000 }),
      getStudentUnit({ studentId, unitId: data.unitId }),
      getLearningStyle({ studentId })
    ]).then((response) => {
      console.log('Student, Options, Student-unit, LearningStyle', response)
      console.log('Unit', data)
      settingStudents(response[0])
      settingOptions(response[1])
      settingStudentUnit(response[2])
      settingLearningStyle(response[3])
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

  const settingLearningStyle = (response) => {
    const { data } = response
    if (data?.content.length) {
      setLearningStyle(data.content[0])
    } else {
      setLearningStyle({ activist: 0, reflector: 0, theorist: 0, pragmatist: 0 })
    }
  }

  const settingStudentUnit = (response) => {
    const { content } = response.data
    if (content && content.length) {
      setStudentUnit(content[0])
      setFinished(content[0].isfinished === 1)
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
      lastAnswerReview()
    } catch (error) {
      console.error(error)
    }
  }

  const resetQuestions = () => {
    setOnReview(false)
    setAnswersList(answersList.map((answer) => ({ ...answer, myOptions: [] })))
  }

  const closeModal = () => {
    setOpenModal(false)
  }

  const getScore = () => {
    const correctList = [...answersList.filter((answer) => answer.isCorrect)]
    return (correctList.length * 10) / answersList.length
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
    const newStudentUnit = {
      ...studentUnit,
      isfinished: answersList.some((answer) => !answer.isCorrect) ? 0 : 1
    }
    setStudentUnit(newStudentUnit)
    setOpenModal(true)
  }

  const settingFeedback = () => {
    const { username } = student
    const { activist, reflector, theorist, pragmatist } = learningStyle

    return {
      username,
      test_score: 0,
      unit_description: data.text_description || '',
      activist: activist.toString(),
      reflector: reflector.toString(),
      theorist: theorist.toString(),
      pragmatist: pragmatist.toString()
    }
  }

  const goNext = () => {
    setOpenModal(false)
    goBack()
  }

  const goBack = () => {
    navigate(`/courses/${studentSubjectId}`)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title={data.unitName} />
      <div className="Unit-container">
        <div className="Unit Unit-flex">
          <div className="Unit-title mb-4">
            <Button color="info" onClick={() => goBack()}>
              Back to Unit list
            </Button>
            <h3>Unit Lesson</h3>
          </div>
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
              {questions.length > 0 && (
                <h4 className="mt-5" style={{ alignSelf: 'center' }}>
                  Questions
                </h4>
              )}
              {data.text && (
                <div className="Unit-text-new">
                  <img src={data.text} style={{ alignSelf: 'center' }} />
                </div>
              )}
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
              <div className="Btn-row-unit">
                {onReview && (
                  <Button className="Unit-btn" color="danger" onClick={() => resetQuestions()}>
                    Restart
                  </Button>
                )}
                {!onReview && (
                  <Button
                    className="Unit-btn"
                    color="success"
                    disabled={questions.length === 0}
                    onClick={() => reviewQuestions()}
                  >
                    Submit
                  </Button>
                )}
              </div>
              {openModal && (
                <ScoreModal
                  isOpen={openModal}
                  score={getScore()}
                  finished={finished}
                  studentUnit={studentUnit}
                  setStudentUnit={setStudentUnit}
                  onReset={closeModal}
                  onNext={goNext}
                  feedback={settingFeedback()}
                />
              )}
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default Unit
