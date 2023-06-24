import './Home.css'
import { Navigate } from 'react-router-dom'
import Header from '../element/Header'
import { getAllSubjects, getStudent, getSubjectsById } from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import { Button, Card, CardBody, CardText, CardTitle } from 'reactstrap'

const Home = () => {
  const studentId = localStorage.getItem('studentId')
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [subjectList, setSubjectList] = useState([])
  const [contentList, setContentList] = useState([])
  const [subjectSelected, setSubjectSected] = useState('')

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getAllSubjects({ page: 0, size: 30 }),
      getSubjectsById(studentId)
    ]).then((response) => {
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

  return (
    <>
      <Header user={student} />
      <div className="Container">
        <div className="Home">
          <h2>What do you want to learn today?</h2>
          {subjectList.length > 0 && (
            <div className="Subject-list">
              {subjectList.map((mySubject, index) => (
                <Button key={index} size="lg" onClick={() => setSubjectSected(mySubject)}>
                  {mySubject.toUpperCase()}
                </Button>
              ))}
            </div>
          )}
          {subjectSelected && (
            <>
              <h2>Which level do you want to start?</h2>
              <div className="Level-list">
                {contentList.map((content) => (
                  <Card key={content.id} className="Card-list">
                    <CardBody>
                      <CardTitle>{`${content.subjectName} - ${content.level}`}</CardTitle>
                      <CardText>{content.description}</CardText>
                    </CardBody>
                  </Card>
                ))}
              </div>
            </>
          )}
        </div>
      </div>
    </>
  )
}

export default Home
