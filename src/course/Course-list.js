import './Course.css'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Navigate, useNavigate } from 'react-router-dom'
import { getStudent, getSubjectsById } from '../lib/tutoring-client'
import {
  Badge,
  Button,
  Card,
  CardBody,
  CardHeader,
  CardSubtitle,
  CardText,
  CardTitle
} from 'reactstrap'

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
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}`)
  }

  const btnText = (studentSubject) => {
    const { progress } = studentSubject
    return progress > 0 ? (progress === 100 ? 'REVIEW' : 'CONTINUE') : 'START'
  }

  const progressColor = (studentSubject) => {
    const { progress } = studentSubject
    return progress > 0 ? (progress === 100 ? 'success' : 'warning') : 'danger'
  }

  return (
    <>
      <Header user={student} subjectCount={subjects.length} title="Courses" />
      <div className="Course-container">
        <div className="Course">
          <div className="Course-title">
            <h3>My Courses list</h3>
            <Button color="info" onClick={() => navigate('/')}>
              Find a course
            </Button>
          </div>
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
                      {btnText(studentSubject)}
                    </Button>
                    <h4 style={{ alignSelf: 'flex-end', marginBottom: 0 }}>
                      <Badge color={progressColor(studentSubject)}>
                        {`${studentSubject.progress} %`}
                      </Badge>
                    </h4>
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
