import './Course.css'
import { Navigate, useLoaderData, useNavigate } from 'react-router-dom'
import { getStudent, getUnitsBySubjectId } from '../lib/tutoring-client'
import { useEffect, useState } from 'react'
import Header from '../element/Header'
import { Button, Card, CardBody, CardText, CardTitle } from 'reactstrap'
import { BsFillCheckCircleFill } from 'react-icons/bs'

export async function loader({ params }) {
  const units = await getUnitsBySubjectId(params.courseId)
  return { units }
}

const Course = () => {
  const studentId = localStorage.getItem('studentId')
  const navigate = useNavigate()
  if (!studentId) {
    return <Navigate replace to="/login" />
  }
  const [student, setStudent] = useState({})
  const { data } = useLoaderData().units

  useEffect(() => {
    getStudent(studentId).then((response) => {
      settingStudents(response)
    })
  }, [studentId])

  const settingStudents = (response) => {
    const { data } = response
    if (data) {
      setStudent(data)
    }
  }

  const goToUnit = (unit) => {
    const { subjectId, unitId } = unit
    navigate(`/courses/${subjectId}/unit/${unitId}`)
  }

  return (
    <>
      <Header user={student} subjectCount={1} title="My units" />
      <div className="Course-container">
        <div className="Course">
          <h3>Units list</h3>
          <div className="Units-list">
            {data.map((unit, index) => (
              <Card key={unit.unitId} className="mt-3">
                <CardBody className="Unit-list-body p-4">
                  <div className="">
                    <CardTitle tag="h5" className="mb-2">
                      {unit.unitName}
                    </CardTitle>
                    <CardText className="text-muted">{unit.description}</CardText>
                  </div>
                  {/* TODO if the unit is finished set an Icon done */}
                  <div style={{ alignSelf: 'center' }}>
                    {index === 2 ? (
                      <h4 style={{ color: 'green' }}>
                        Finished <BsFillCheckCircleFill />
                      </h4>
                    ) : (
                      <Button color="dark" onClick={() => goToUnit(unit)}>
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
            <Button block style={{ alignSelf: 'center', flex: 1 }} color="success" disabled>
              TEST
            </Button>
          </div>
        </div>
      </div>
    </>
  )
}

export default Course
