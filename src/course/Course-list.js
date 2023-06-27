import './Course.css'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Navigate, useNavigate } from 'react-router-dom'
import { getStudent, getSubjectsById } from '../lib/tutoring-client'
import { Button, Card, CardBody, CardHeader, CardSubtitle, CardText, CardTitle } from 'reactstrap'

const CoursesList = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [subjects, setSubject] = useState([])

  useEffect(() => {
    Promise.all([getStudent(studentId), getSubjectsById(studentId)]).then((response) => {
      console.log(response)
      settingStudents(response[0])
      settingSubjects(response[1])
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingSubjects = (response) => {
    const { data } = response
    if (data) {
      setSubject(data)
    }
  }

  const goToCourse = (studentSubject) => {
    const { subjectId } = studentSubject
    console.log(subjectId)
    navigate(`/courses/${subjectId}`)
  }

  return (
    <>
      <Header user={student} subjectCount={subjects.length} title="Courses" />
      <div className="Course-container">
        <div className="Course">
          <h3>My Courses list</h3>
          <div className="Course-body">
            {subjects.map((studentSubject) => (
              <Card key={studentSubject.studentSubjectId} className="Card-container">
                <CardHeader>
                  <CardTitle tag="h5">
                    {`${studentSubject.subject.subjectName} - ${studentSubject.subject.level}`}
                  </CardTitle>
                </CardHeader>
                <CardBody className="Card-body">
                  <div className="mb-3 mt-2">
                    <CardSubtitle className="mb-2 text-muted" tag="h6">
                      Description
                    </CardSubtitle>
                    <CardText>{studentSubject.subject.description}</CardText>
                  </div>
                  <div className="Card-bottom">
                    <Button onClick={() => goToCourse(studentSubject)}>
                      {studentSubject.progress > 0 ? 'CONTINUE' : 'START'}
                    </Button>
                    <CardTitle style={{ color: 'red' }} tag="h3">
                      {`${studentSubject.progress} %`}
                    </CardTitle>
                  </div>
                </CardBody>
              </Card>
            ))}
          </div>
        </div>
      </div>
    </>
  )
}

export default CoursesList
