import './Home.css'
import { Navigate, useNavigate } from 'react-router-dom'
import Header from '../element/Header'
import {
  addSubjectStudent,
  getAllSubjects,
  getStudent,
  getSubjectsById
} from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import { Button, Card, CardBody, CardText, CardTitle } from 'reactstrap'

const Home = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [subjectList, setSubjectList] = useState([])
  const [contentList, setContentList] = useState([])
  const [subjectSelected, setSubjectSected] = useState('')
  const [studentSubjectList, setStudentSubject] = useState([])

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getAllSubjects({ page: 0, size: 30 }),
      getSubjectsById(studentId)
    ]).then((response) => {
      console.log('student, Subjects, StudentSubjectByID', response)
      settingStudents(response[0])
      settingSubjects(response[1])
      //Student Subject
      const { data } = response[2]
      console.log('data:', data)
      setStudentSubject(data)
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingSubjects = (response) => {
    const { content } = response.data
    const mySubject = []
    if (content) {
      setContentList(content)
    }

    content.forEach((subject) => {
      if (!mySubject.includes(subject.subjectName)) {
        mySubject.push(subject.subjectName)
      }
    })
    setSubjectList(mySubject)
  }

  const joinSubject = (currentContent) => {
    console.log('joining', currentContent)
    const { subjectId } = currentContent
    addSubjectStudent({ studentId, subjectId, progress: 0 }).then(() => {
      goToCoursesList()
    })
  }

  const goToQuestionnaire = () => {
    navigate('/questionnaire')
  }

  const isSubscribed = ({ subjectId }) => {
    return studentSubjectList.some((studentSub) => studentSub.subjectId === subjectId)
  }

  const goToCourse = ({ subjectId }) => {
    const studentSubject = studentSubjectList.find(
      (studentSub) => studentSub.subjectId === subjectId
    )
    navigate(`/courses/${studentSubject.studentSubjectId}`)
  }

  const goToCoursesList = () => {
    navigate('/courses')
  }

  return (
    <>
      <Header user={student} subjectCount={studentSubjectList.length} />
      <div className="Container">
        <div className="Home">
          <div className="Home-head">
            <h2>What do you want to learn today?</h2>
            <div>
              <Button
                style={{ marginRight: '5px' }}
                color="success"
                onClick={() => goToCoursesList()}
              >
                My Courses
              </Button>
              <Button color="info" onClick={() => goToQuestionnaire()}>
                Learning Questionnaire
              </Button>
            </div>
          </div>
          {subjectList.length > 0 && (
            <div className="Subject-list">
              {subjectList.map((mySubject, index) => (
                <Button
                  key={index}
                  color={mySubject === subjectSelected ? 'dark' : 'secondary'}
                  size="lg"
                  onClick={() => setSubjectSected(mySubject)}
                >
                  {mySubject.toUpperCase()}
                </Button>
              ))}
            </div>
          )}
          {subjectSelected && (
            <>
              <h2 style={{ paddingTop: '50px' }}>Which level do you want to start?</h2>
              <div className="Level-list">
                {contentList.map((content) => {
                  if (content.subjectName === subjectSelected) {
                    return (
                      <Card key={content.subjectId} className="Card-list">
                        <CardBody>
                          <CardTitle tag="h5">{`${content.subjectName} - ${content.level}`}</CardTitle>
                          <CardText>{content.description}</CardText>
                        </CardBody>
                        {isSubscribed(content) ? (
                          <Button onClick={() => goToCourse(content)}>CONTINUE COURSE</Button>
                        ) : (
                          <Button onClick={() => joinSubject(content)}>JOIN COURSE</Button>
                        )}
                      </Card>
                    )
                  }
                  return <></>
                })}
              </div>
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default Home
