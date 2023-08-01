import { Form, Navigate, useNavigate } from 'react-router-dom'
import { getLearningStyle, getStudent } from './lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from './element/Header'
import { Button, Card, CardTitle, CardBody, CardText, FormGroup, Input, Label } from 'reactstrap'
import { postGPTEssay } from './lib/gpt-client'

const WritingTest = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }

  const [student, setStudent] = useState({})
  const [essay, setEssay] = useState({ essay_topic: '', essay_content: '' })
  const [gptAnswer, setGptAnswer] = useState('')
  const [learningStyle, setLearningStyle] = useState({})
  const [loadingFeedback, setLoadingFeedback] = useState(false)
  const [onFeedback, setOnFeedback] = useState(false)
  const [feedbackError, setFeedbackError] = useState(false)

  const navigate = useNavigate()

  useEffect(() => {
    Promise.all([getStudent(studentId), getLearningStyle({ studentId })]).then((response) => {
      console.log('Student', response)
      settingStudents(response[0])
      settingLearningStyle(response[1])
    })
  }, [])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingLearningStyle = (response) => {
    const { data } = response
    if (data.content.length) {
      setLearningStyle(data.content[0])
    } else {
      settingLearningStyle({ activist: 0, reflector: 0, theorist: 0, pragmatist: 0 })
    }
  }

  const submitEssay = () => {
    const { username } = student
    const { activist, reflector, theorist, pragmatist } = learningStyle
    const params = {
      ...essay,
      username: username,
      essay_subject: 'English',
      activist: activist.toString(),
      reflector: reflector.toString(),
      theorist: theorist.toString(),
      pragmatist: pragmatist.toString()
    }
    setGptAnswer('')
    setLoadingFeedback(true)
    setOnFeedback(true)
    postGPTEssay(params)
      .then((response) => {
        console.log('Submit essay response', response.data)
        setGptAnswer(response.data)
        setLoadingFeedback(false)
      })
      .catch((error) => {
        console.error(error.message)
        setLoadingFeedback(false)
        setFeedbackError(true)
      })
  }

  const tryAgain = () => {
    setLoadingFeedback(false)
    setGptAnswer('')
    setFeedbackError(false)
    setEssay({})
    setOnFeedback(false)
  }

  const isComplete = () => {
    return essay.essay_topic !== '' && essay.essay_content !== ''
  }

  const goBack = () => {
    navigate(`/courses/`)
  }

  const goHome = () => {
    navigate('/')
  }

  return (
    <>
      <Header user={student} subjectCount={1} title="Writing Test" />
      <div className="Course-container">
        <div className="Course Final-body">
          <div className="Final-test-title">
            <div style={{ display: 'flex' }}>
              <Button color="info" onClick={() => goBack()}>
                Go to my Courses
              </Button>
              <Button style={{ marginLeft: '10px' }} color="info" onClick={() => goHome()}>
                Find Courses
              </Button>
            </div>
            <h3>Writing Test</h3>
          </div>
          <h5 style={{ marginTop: '10px' }}>
            Write a small essay from any favorite topic that you have.
          </h5>
          {!onFeedback && (
            <Form>
              <FormGroup>
                <Label for="essay_topic">Topic:</Label>
                <Input
                  id="essay_topic"
                  name="essay_topic"
                  placeholder="Essay Topic"
                  value={essay.essay_topic}
                  onChange={(e) => setEssay({ ...essay, essay_topic: e.target.value })}
                />
              </FormGroup>
              <FormGroup>
                <Label for="essay_content">Essay:</Label>
                <Input
                  id="essay_content"
                  name="essay_content"
                  type="textarea"
                  value={essay.essay_content}
                  rows={15}
                  onChange={(e) => setEssay({ ...essay, essay_content: e.target.value })}
                />
              </FormGroup>
            </Form>
          )}
          {onFeedback && (
            <Card color="light" style={{ marginTop: '1em' }}>
              <CardBody>
                <CardTitle tag="h5">Feedback</CardTitle>
                {loadingFeedback && <CardText>Loading feedback...</CardText>}
                {!loadingFeedback && gptAnswer && <CardText>{gptAnswer}</CardText>}
                {!loadingFeedback && feedbackError && <CardText>Something went wrong</CardText>}
              </CardBody>
            </Card>
          )}
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            {!onFeedback && (
              <Button
                style={{ width: '25%' }}
                color="success"
                onClick={submitEssay}
                disabled={!isComplete()}
              >
                Submit
              </Button>
            )}
            {onFeedback && (
              <Button
                style={{ width: '25%', marginTop: '20px' }}
                color="info"
                onClick={tryAgain}
                disabled={loadingFeedback}
              >
                Try Again
              </Button>
            )}
          </div>
        </div>
      </div>
    </>
  )
}

export default WritingTest
