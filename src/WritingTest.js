import { Form, Navigate, useNavigate } from 'react-router-dom'
import { getStudent } from './lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from './element/Header'
import { Button, Card, CardBody, CardText, FormGroup, Input, Label } from 'reactstrap'
import { postGPTEssay } from './lib/gpt-client'

const WritingTest = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }

  const [student, setStudent] = useState({})
  const [essay, setEssay] = useState({ essay_topic: '', essay_content: '' })
  const [gptAnswer, setGptAnswer] = useState('')

  const navigate = useNavigate()

  useEffect(() => {
    Promise.all([getStudent(studentId)]).then((response) => {
      console.log('Student', response)
      settingStudents(response[0])
    })
  }, [])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const submitEssay = () => {
    const { username } = student
    const params = { ...essay, userName: username }
    setGptAnswer('')
    postGPTEssay(params)
      .then((response) => {
        console.log('Submit essay response', response.data)
        setGptAnswer(response.data)
      })
      .catch((error) => {
        console.error(error.message)
      })
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
      <Header user={student} subjectCount={1} title="Final Test" />
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
            <h3>Final Test</h3>
          </div>
          <h5 style={{ marginTop: '10px' }}>
            Write a small essay from any favorite topic that you have.
          </h5>
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
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <Button
              style={{ width: '25%' }}
              color="success"
              onClick={submitEssay}
              disabled={!isComplete()}
            >
              Submit
            </Button>
          </div>
          {gptAnswer && (
            <Card color="info" style={{ marginTop: '1em' }}>
              <CardBody>
                <CardText>{gptAnswer}</CardText>
              </CardBody>
            </Card>
          )}
        </div>
      </div>
    </>
  )
}

export default WritingTest
