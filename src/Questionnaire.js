import './home/Home.css'
import Header from './element/Header'
import { Navigate, useNavigate } from 'react-router-dom'
import { useEffect, useState } from 'react'
import {
  editLearningStyle,
  getLearningStyle,
  getStudent,
  postLearningStyle
} from './lib/tutoring-client'
import { getLearningQuestionnaire } from './lib/local-client'
import { Alert, Button, Input, Label } from 'reactstrap'
import { useTranslation } from 'react-i18next'

const LearningQuestion = (args) => {
  const { question: quest, questionnaire, setQuestionare } = args
  const { t } = useTranslation()

  const handleRadioBtn = (event) => {
    const newQuestionnaire = questionnaire.map((searchQuest) => {
      if (searchQuest.id === quest.id) {
        return { ...searchQuest, answer: event.target.value }
      } else return searchQuest
    })
    setQuestionare(newQuestionnaire)
  }

  return (
    <div style={{ paddingBottom: '10px' }}>
      <h5>{`${quest.id}. ${quest.question}`}</h5>
      <div className="Quest-radio">
        <Label>
          <Input
            type="radio"
            name={`${quest.id}-agree`}
            value="agree"
            checked={quest.answer === 'agree'}
            onChange={handleRadioBtn}
          />
          <span style={{ marginLeft: '5px' }}>{t('agree')}</span>
        </Label>
        <Label>
          <Input
            type="radio"
            name={`${quest.id}-disagree`}
            value="disagree"
            checked={quest.answer === 'disagree'}
            onChange={handleRadioBtn}
          />
          <span style={{ marginLeft: '5px' }}>{t('disagree')}</span>
        </Label>
      </div>
    </div>
  )
}

const Questionnaire = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  const { t } = useTranslation()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [questionnaire, setQuestionare] = useState([])
  const [score, setScore] = useState({})
  const [learningStyle, setLearningStyle] = useState({})
  const [showAlert, setShowAlert] = useState(false)

  // Score list answers and total on this
  const scoreList = {
    activist: {
      list: [2, 4, 6, 10, 17, 23, 24, 32, 34, 38, 40, 43, 45, 48, 58, 64, 71, 72, 74, 79],
      total: 0
    },
    reflector: {
      list: [7, 13, 15, 16, 25, 28, 29, 31, 33, 36, 39, 41, 46, 52, 55, 60, 62, 66, 67, 76],
      total: 0
    },
    theorist: {
      list: [1, 3, 8, 12, 14, 18, 20, 22, 26, 30, 42, 47, 51, 57, 61, 63, 68, 75, 77, 78],
      total: 0
    },
    pragmatist: {
      list: [5, 9, 11, 19, 21, 27, 35, 37, 44, 49, 50, 53, 54, 56, 59, 65, 69, 70, 73, 80],
      total: 0
    }
  }

  useEffect(() => {
    setScore(scoreList)
    Promise.all([
      getStudent(studentId),
      getLearningQuestionnaire(),
      getLearningStyle({ studentId })
    ]).then((response) => {
      settingStudents(response[0])
      settingQuestionare(response[1])
      settingLearningStyle(response[2])
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
   * Setting up the questio for the learning style questionnaire  into "questionnaire" state
   * @param response - response from API
   */
  const settingQuestionare = (response) => {
    const { data } = response
    if (data) {
      setQuestionare(data)
    }
  }

  /**
   * Setting up the learning style data into "learningStyle" state
   * @param response - response from API
   */
  const settingLearningStyle = (response) => {
    const { data } = response
    if (data.content.length) {
      setLearningStyle(data.content[0])
    }
  }

  /**
   * Setting up of the questions answer and sending to learning style API
   */
  const onFinishQuestionnaire = () => {
    // To Continue
    const { activist, reflector, theorist, pragmatist } = score

    activist.total = filterListTotal(activist)
    setScore({ ...score, activist })

    reflector.total = filterListTotal(reflector)
    setScore({ ...score, reflector })

    theorist.total = filterListTotal(theorist)
    setScore({ ...score, theorist })

    pragmatist.total = filterListTotal(pragmatist)
    setScore({ ...score, pragmatist })

    const newLearningStyle = {
      activist: activist.total,
      reflector: reflector.total,
      theorist: theorist.total,
      pragmatist: pragmatist.total,
      studentId
    }
    if (learningStyle.learningStyleId) {
      const edited = { ...learningStyle, ...newLearningStyle }
      setLearningStyle(edited)
      editLearningStyle(edited)
        .then((response) => {
          const { data } = response
          setLearningStyle(data)
          setShowAlert(true)
          setTimeout(() => {
            setShowAlert(false)
            navigate('/courses')
          }, 2000)
        })
        .catch((error) => console.error(error))
    } else {
      setLearningStyle(newLearningStyle)
      postLearningStyle(newLearningStyle)
        .then((response) => {
          const { data } = response
          setLearningStyle(data)
          setShowAlert(true)
          setTimeout(() => {
            setShowAlert(false)
            navigate('/courses')
          }, 2000)
        })
        .catch((error) => console.error(error))
    }
  }

  /**
   * Calculates the total answers related to a specific behaviour on the learning style
   * @param scoreObject - object
   * @returns number - quantity of agree related to that object
   */
  const filterListTotal = (scoreObject) => {
    return scoreObject.list.filter((item) =>
      questionnaire.some((quest) => quest.id === item && quest.answer === 'agree')
    ).length
  }

  return (
    <>
      <Header user={student} subjectCount="1" />
      <div className="Container">
        <div className="Home">
          <h2>{t('learning_style_quest')}</h2>
          <p>{t('learning_style_description')}</p>
          <div className="Quest-container">
            {questionnaire.length &&
              questionnaire.map((quest) => (
                <LearningQuestion
                  key={quest.id}
                  question={quest}
                  questionnaire={questionnaire}
                  setQuestionare={setQuestionare}
                />
              ))}
          </div>
          <div
            style={{ display: 'flex', justifyContent: showAlert ? 'space-between' : 'flex-end' }}
          >
            <Alert
              color="success"
              isOpen={showAlert}
              style={{ alignSelf: 'center', margin: 0, padding: '8px 15px' }}
            >
              {t('learning_style_update_success')}
            </Alert>
            <Button
              color="success"
              size="lg"
              disabled={questionnaire.some((quest) => quest.answer === 'none')}
              onClick={() => onFinishQuestionnaire()}
            >
              {t('learning_style_finis_btn')}
            </Button>
          </div>
        </div>
      </div>
    </>
  )
}

export default Questionnaire
