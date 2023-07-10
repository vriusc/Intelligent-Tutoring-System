import './Home.css'
import Header from '../element/Header'
import { Navigate } from 'react-router-dom'
import { useEffect, useState } from 'react'
import {
  editLearningStyle,
  getLearningStyle,
  getStudent,
  postLearningStyle
} from '../lib/tutoring-client'
import { getLearningQuestionnaire } from '../lib/local-client'
import { Button, Input, Label } from 'reactstrap'

const LearningQuestion = (args) => {
  const { question: quest, questionnaire, setQuestionare } = args

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
            onClick={handleRadioBtn}
          />
          <span style={{ marginLeft: '5px' }}>Agree</span>
        </Label>
        <Label>
          <Input
            type="radio"
            name={`${quest.id}-disagree`}
            value="disagree"
            checked={quest.answer === 'disagree'}
            onClick={handleRadioBtn}
          />
          <span style={{ marginLeft: '5px' }}>Disagree</span>
        </Label>
      </div>
    </div>
  )
}

const Questionnaire = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [questionnaire, setQuestionare] = useState([])
  const [score, setScore] = useState({})
  const [learningStyle, setLearningStyle] = useState({})

  const description = `There is no time limit to this questionnaire. It will probably take you 10-15 minutes. The accuracy of the results depends on how honest you can be. There are no right or wrong answers. If you agree more than you disagree with a statement choose the option agree. If you disagree more than you agree choose the option disagree. Be sure to mark each item with either agree or desagree. When you have completed the questionnaire, continue by selecting 'End Questionnaire'`
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

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingQuestionare = (response) => {
    const { data } = response
    if (data) {
      setQuestionare(data)
    }
  }

  const settingLearningStyle = (response) => {
    const { data } = response
    if (data.content.length) {
      setLearningStyle(data.content[0])
    }
  }

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
        })
        .catch((error) => console.error(error))
    } else {
      setLearningStyle(newLearningStyle)
      postLearningStyle(newLearningStyle)
        .then((response) => {
          const { data } = response
          setLearningStyle(data)
        })
        .catch((error) => console.error(error))
    }
  }

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
          <h2>Learning Styles Questionnaire</h2>
          <p>{description}</p>
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
          <Button
            style={{ alignSelf: 'end' }}
            color="success"
            size="lg"
            onClick={() => onFinishQuestionnaire()}
          >
            END QUESTIONNAIRE
          </Button>
        </div>
      </div>
    </>
  )
}

export default Questionnaire
