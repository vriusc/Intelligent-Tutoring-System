import './Course.css'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Navigate, useNavigate } from 'react-router-dom'
import { getLearningStyle, getStudent, getSubjectsById } from '../lib/tutoring-client'
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
import LearningStyleModal from './LearningStyleModal'
import { useTranslation } from 'react-i18next'

const CoursesList = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  const { t } = useTranslation()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [subjects, setSubject] = useState([])
  const [openModal, setOpenModal] = useState(false)
  const [, setLearningStyle] = useState({})

  useEffect(() => {
    Promise.all([
      getStudent(studentId),
      getSubjectsById(studentId),
      getLearningStyle({ studentId })
    ])
      .then((response) => {
        console.log(response)
        settingStudents(response[0])
        settingSubjects(response[1])
        settingLearningStyle(response[2])
      })
      .catch((response) => {
        console.error(response.error)
        setOpenModal(true)
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

  const settingLearningStyle = (response) => {
    const { data } = response
    if (data.content.length) {
      setLearningStyle(data.content[0])
    } else {
      setOpenModal(true)
    }
  }

  return (
    <>
      <Header user={student} subjectCount={subjects.length} title={t('my_courses')} />
      <LearningStyleModal openModal={openModal} setOpenModal={setOpenModal} />
      <div className="Course-container">
        <div className="Course">
          <div className="Course-title">
            <h3>My Courses list</h3>
            <Button color="info" onClick={() => navigate('/')}>
              {t('find_a_course')}
            </Button>
          </div>
          <div className="Course-body">
            {subjects.map((studentSubject) => (
              <CourseCard key={studentSubject.studentSubjectId} studentSubject={studentSubject} />
            ))}
          </div>
        </div>
      </div>
    </>
  )
}

const CourseCard = (args) => {
  const { studentSubject } = args
  const navigate = useNavigate()
  const { t } = useTranslation()

  const goToCourse = (studentSubject) => {
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}`)
  }

  const btnText = (studentSubject) => {
    const { progress } = studentSubject
    return progress > 0 ? (progress === 100 ? t('review') : t('continue')) : t('start')
  }

  const progressColor = (studentSubject) => {
    const { progress } = studentSubject
    return progress > 0 ? (progress === 100 ? 'success' : 'warning') : 'danger'
  }

  return (
    <Card className="Card-container">
      <CardHeader>
        <CardTitle tag="h5">
          {`${studentSubject.subject.subjectName} - ${studentSubject.subject.level}`}
        </CardTitle>
      </CardHeader>
      <CardBody className="Card-body">
        <div className="mb-3 mt-2">
          <CardSubtitle className="mb-2 text-muted" tag="h6">
            {t('description')}
          </CardSubtitle>
          <CardText>{studentSubject.subject.description}</CardText>
        </div>
        <div className="Card-bottom">
          <Button onClick={() => goToCourse(studentSubject)}>{btnText(studentSubject)}</Button>
          <h4 style={{ alignSelf: 'flex-end', marginBottom: 0 }}>
            <Badge color={progressColor(studentSubject)}>{`${studentSubject.progress} %`}</Badge>
          </h4>
        </div>
      </CardBody>
    </Card>
  )
}

export default CoursesList
