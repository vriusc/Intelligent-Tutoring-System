import { Form, Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import { getStudent, getStudentSubjectById } from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Button, FormGroup, Input, Label } from 'reactstrap'
import { postGPTEssay } from '../lib/gpt-client'

export async function loader({ params }) {
  const studentSubject = await getStudentSubjectById(params.courseId)
  return { studentSubject }
}

const FinalTest = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const { data: studentSubject } = useLoaderData().studentSubject

  const [student, setStudent] = useState({})
  const [essay, setEssay] = useState({ essay_topic: '', essay_content: '' })

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
    postGPTEssay(params)
      .then((response) => {
        console.log('Submit essay response', response.data)
      })
      .catch((error) => {
        console.error(error.message)
      })
  }

  const isComplete = () => {
    return essay.essay_topic !== '' && essay.essay_content !== ''
  }

  const goBack = () => {
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}`)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title="Final Test" />
      <div className="Course-container">
        <div className="Course Final-body">
          <div className="Final-test-title">
            <Button color="info" onClick={() => goBack()}>
              Back
            </Button>
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
          {/* TODO after getting the result, publish them */}
        </div>
      </div>
    </>
  )
}

export default FinalTest
