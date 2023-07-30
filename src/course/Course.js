import './Course.css'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import {
  getStudent,
  getStudentSubjectById,
  getStudentUnit,
  getUnitsBySubjectId,
  putStudentSubject
} from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Button, Card, CardBody, CardText, CardTitle } from 'reactstrap'
import { BsFillCheckCircleFill } from 'react-icons/bs'

export async function loader({ params }) {
  const studentSubject = await getStudentSubjectById(params.courseId)
  const units = await getUnitsBySubjectId(studentSubject.data.subjectId)
  return { units, studentSubject }
}

const Course = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const [unitsSolved, setUnitsSolved] = useState([])
  const [currentUnit, setCurrentUnit] = useState(0)
  const { data: unitList } = useLoaderData().units
  const { data: studentSubject } = useLoaderData().studentSubject

  useEffect(() => {
    Promise.all([getStudent(studentId), getStudentUnit({ studentId })]).then((response) => {
      console.log(response)
      settingStudents(response[0])
      settingStudentUnit(response[1])
      checkSubjectProgress(response[1].data.content)
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const settingStudentUnit = (response) => {
    const { content } = response.data
    setUnitsSolved(content)
  }

  const goToUnit = (unit) => {
    const { unitId } = unit
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}/unit/${unitId}`)
  }

  const goToHistory = (unit) => {
    const { unitId } = unit
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}/history/${unitId}`)
  }

  const goToTesting = () => {
    const { studentSubjectId } = studentSubject
    navigate(`/courses/${studentSubjectId}/finalTest`)
  }

  const checkFinish = (unit) => {
    return unitsSolved.some((solve) => solve.unitId === unit.unitId && solve.isfinished === 1)
  }

  const checkSubjectProgress = (solvedList) => {
    console.log(studentSubject, solvedList, unitList)
    const total = unitList.length
    const count = unitList.filter((thisUnit) => {
      return solvedList.some(
        (solved) => solved.unitId === thisUnit.unitId && solved.isfinished === 1
      )
    }).length
    const currentProgress = (count / total) * 100
    if (currentProgress !== studentSubject.progress) {
      const { studentSubjectId, subjectId, studentId } = studentSubject
      putStudentSubject({ studentSubjectId, subjectId, studentId, progress: currentProgress }).then(
        (response) => {
          console.log(response, total, count, currentProgress)
        }
      )
    }
    setCurrentUnit(unitList[count].unitId)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title="My units" />
      <div className="Course-container">
        <div className="Course">
          <h3>Units list</h3>
          <div className="Units-list">
            {unitList.map((unit) => (
              <Card key={unit.unitId} className="mt-3">
                <CardBody className="Unit-list-body p-4">
                  <div className="">
                    <CardTitle tag="h5" className="mb-2">
                      {unit.unitName}
                    </CardTitle>
                    <CardText className="text-muted">{unit.description}</CardText>
                  </div>
                  <div className="Finish-btn">
                    {checkFinish(unit) ? (
                      <>
                        <h4 style={{ color: 'green', marginRight: '10px' }}>
                          Finished <BsFillCheckCircleFill />
                        </h4>
                        <Button color="warning" onClick={() => goToHistory(unit)}>
                          HISTORY
                        </Button>
                      </>
                    ) : (
                      <Button
                        color="dark"
                        disabled={!unit.materials_path || unit.unitId !== currentUnit}
                        onClick={() => goToUnit(unit)}
                      >
                        START
                      </Button>
                    )}
                  </div>
                </CardBody>
              </Card>
            ))}
          </div>
          <div className="Course-test-cont">
            <h5 style={{ alignSelf: 'center', margin: 0, flex: 2 }}>
              Once you finished all the units you can start the test
            </h5>
            <Button
              block
              style={{ alignSelf: 'center', flex: 1 }}
              color="success"
              disabled={studentSubject.progress === 0}
              onClick={() => goToTesting()}
            >
              WRITING TEST
            </Button>
          </div>
        </div>
      </div>
    </>
  )
}

export default Course
