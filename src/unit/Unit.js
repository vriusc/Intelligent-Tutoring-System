import './Unit.css'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import {
  getAllSubjects,
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
import { useTranslation } from 'react-i18next'

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
  const [subject, setSubject] = useState({})

  const navigate = useNavigate()
  const { t } = useTranslation()
  const { data } = useLoaderData().unit
  const studentSubjectId = useLoaderData().studentSubjectId

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getOptions({ size: 1000 }),
      getStudentUnit({ studentId, unitId: data.unitId }),
      getLearningStyle({ studentId }),
      getAllSubjects({ subjectId: data.subjectId })
    ]).then((response) => {
      console.log('Student, Options, Student-unit, LearningStyle, Subject', response)
      console.log('Unit', data)
      settingStudents(response[0])
      settingOptions(response[1])
      settingStudentUnit(response[2])
      settingLearningStyle(response[3])
      settingSubject(response[4])
    })
  }, [studentId])

  /**
   * Setting up the student data into "student" state
   * @param response - response from API
   */
  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  /**
   * Setting up the Options list data into "questionOptions" state
   * @param response - response from API
   */
  const settingOptions = (response) => {
    const { content } = response.data
    if (content) {
      setQuestOptions(content)
    }
  }

  /**
   * Setting up the learning style data into "learningStyle" state
   * @param response - response from API
   */
  const settingLearningStyle = (response) => {
    const { data } = response
    if (data?.content.length) {
      setLearningStyle(data.content[0])
    } else {
      setLearningStyle({ activist: 0, reflector: 0, theorist: 0, pragmatist: 0 })
    }
  }

  /**
   * Setting up the student_unit data into "studentUnit" state
   * @param response - response from API
   */
  const settingStudentUnit = (response) => {
    const { content } = response.data
    if (content && content.length) {
      setStudentUnit(content[0])
      setFinished(content[0].isfinished === 1)
    } else {
      setStudentUnit({ studentId, unitId: data.unitId, isfinished: 0 })
    }
  }

  /**
   * Setting up the subject data into "subject" state
   * @param response
   */
  const settingSubject = (response) => {
    const { content } = response.data
    if (content && content.length > 0) {
      setSubject(content[0])
    }
  }

  /**
   * opens the question list and gets the question list into "questions" state
   */
  const goToQuestions = () => {
    getQuestionsByUnitId(data.unitId).then((response) => {
      const data = response.data.content
      console.log('Questions', data)
      setQuestions(data)
      setShowQuestions(true)
      createAnswerList(data)
    })
  }

  /**
   * Filter the all the options that belongs to a questionId
   * @param thisOptions - Option list that has to be filtered
   * @param questionId - Question ID
   * @returns optionList[] - optionList array
   */
  const myOptions = (thisOptions, questionId) => {
    return [...thisOptions.filter((option) => option.questionId === questionId)]
  }

  /**
   * Start the review of the questions on the Unit
   * - Check one by one question
   * - Setting up all the info into the "answerList" state
   * - Opens the modal for Score
   */
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

  /**
   * Restart the questions after the submittion allows to change the answers
   */
  const resetQuestions = () => {
    setOnReview(false)
    setAnswersList(answersList.map((answer) => ({ ...answer, myOptions: [] })))
  }

  /**
   * Close the Score Modal
   */
  const closeModal = () => {
    setOpenModal(false)
  }

  /**
   * Gets the score of the Questions answered
   * @returns {number} - score number from 0 to 10
   */
  const getScore = () => {
    const correctList = [...answersList.filter((answer) => answer.isCorrect)]
    return (correctList.length * 10) / answersList.length
  }

  /**
   * Setting up the state answerList with all the options correct answers
   * @param list - list of Questions
   */
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

  /**
   * Check if the options selected is correct or no
   * @param quest - Question object
   * @returns {boolean|*|boolean} - TRUE: if the options selected is correct
   */
  const checkCorrectQuest = (quest) => {
    if (quest.myOptions.length > 0) {
      const allCorrect = !quest.myOptions.some((opt) => opt.isCorrect !== 1)
      return allCorrect && quest.myOptions.length === quest.correctOptions.length
    } else {
      return quest.isCorrect
    }
  }

  /**
   * One step ahead of the review, where it gets the score and opens the Score modal
   */
  const lastAnswerReview = () => {
    const newStudentUnit = {
      ...studentUnit,
      isfinished: getScore() < 8 ? 0 : 1
    }
    setStudentUnit(newStudentUnit)
    setOpenModal(true)
  }

  /**
   * Setting up info for the question-feedback consultation to the AI
   * @returns {{activist: string, test_score: number, reflector: string, subject: subjectName, unit_description: string, theorist: string, pragmatist: string, username}}
   */
  const settingFeedback = () => {
    const { username } = student
    const { activist, reflector, theorist, pragmatist } = learningStyle
    return {
      username,
      test_score: 0,
      unit_description: data.text_description || '',
      subject: subject.subjectName,
      activist: activist.toString(),
      reflector: reflector.toString(),
      theorist: theorist.toString(),
      pragmatist: pragmatist.toString()
    }
  }

  /**
   * Setting up info for the scoreModal consultion to the AI
   * @returns {{unit: *, unit_description, username}}
   */
  const settingModal = () => {
    const { username } = student

    return {
      username,
      unit: data.unitName,
      unit_description: data.description
    }
  }

  /**
   * Sending the Question options to Score Modal
   * @returns {*[]}
   */
  const settingQuestOptions = () => {
    const questOpt = []
    questions.forEach((quest) => {
      const { questionOrder, question, description, questionId } = quest.questions
      questOpt.push({
        questionOrder,
        question,
        description,
        options: myOptions(questOptions, questionId)
      })
    })
    return questOpt
  }

  /**
   * Close score modal and navigate to the current Course
   */
  const goNext = () => {
    setOpenModal(false)
    goBack()
  }

  /**
   * Navigate the current course
   */
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
              {t('back_unit_list')}
            </Button>
            <h3>{t('unit_lesson')}</h3>
          </div>
          <h5>{t('description')}</h5>
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
            {t('go_to_questions')}
          </Button>
          {showQuestions && (
            <>
              {questions.length > 0 && (
                <h4 className="mt-5" style={{ alignSelf: 'center' }}>
                  {t('questions')}
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
                  questModal={settingModal()}
                  subjectId={data.subject.subjectId}
                />
              ))}
              {questions.length === 0 && (
                <h3 style={{ alignSelf: 'center', marginTop: '2em' }}>
                  <Badge color="info">{t('no_questions_in_unit')}</Badge>
                </h3>
              )}
              <div className="Btn-row-unit">
                {onReview && (
                  <Button className="Unit-btn" color="danger" onClick={() => resetQuestions()}>
                    {t('restart')}
                  </Button>
                )}
                {!onReview && (
                  <Button
                    className="Unit-btn"
                    color="success"
                    disabled={questions.length === 0}
                    onClick={() => reviewQuestions()}
                  >
                    {t('submit')}
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
                  questionOptions={settingQuestOptions()}
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
