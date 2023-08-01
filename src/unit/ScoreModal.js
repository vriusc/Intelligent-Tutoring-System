import { Alert, Button, Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap'
import { useEffect, useState } from 'react'
import { postStudentUnit, putStudentUnit } from '../lib/tutoring-client'
import { postGPTFeedback } from '../lib/gpt-client'

const ScoreModal = (args) => {
  const { score, isOpen, finished, studentUnit, setStudentUnit, onReset, onNext, username } = args

  const [loadingFeedback, setLoadingFeedback] = useState(true)
  const [gptFeedback, setGPTFeedback] = useState('')

  useEffect(() => {
    if (isOpen) {
      if (!finished) {
        if (studentUnit.studentUnitId) {
          const { studentUnitId, isfinished } = studentUnit
          putStudentUnit({ studentUnitId, isfinished }).then(settingStudentUnit)
        } else {
          postStudentUnit(studentUnit).then(settingStudentUnit)
        }
      }
      // FEEDBACK
      setLoadingFeedback(true)
      setGPTFeedback('')
      const params = {
        username,
        test_score: score
      }
      postGPTFeedback(params)
        .then((response) => {
          setGPTFeedback(response.data)
          setLoadingFeedback(false)
        })
        .catch((error) => {
          console.error(error.message)
        })
    }
  }, [isOpen])

  const settingStudentUnit = (response) => {
    const { data } = response
    setStudentUnit(data)
  }
  // TODO Check what to do when is a finished unit
  return (
    <Modal isOpen={isOpen}>
      <ModalHeader>{loadingFeedback ? 'Score' : `Score: ${score}`}</ModalHeader>
      <ModalBody>
        {score === 10 && gptFeedback && <Alert color="success">Congratulations!!</Alert>}
        {loadingFeedback && <Alert color={score === 10 ? 'light' : 'dark'}>Loading score...</Alert>}
        {!loadingFeedback && gptFeedback && <Alert color="warning">{gptFeedback}</Alert>}
      </ModalBody>
      <ModalFooter>
        <div className="Modal-bottom">
          {loadingFeedback && (
            <Button color="info" disabled="true">
              Loading...
            </Button>
          )}
          {!loadingFeedback && studentUnit.isfinished === 1 && (
            <Button color="success" onClick={() => onNext()} disabled={loadingFeedback}>
              Next Unit
            </Button>
          )}
          {!loadingFeedback && studentUnit.isfinished !== 1 && (
            <Button color="warning" onClick={() => onReset()} disabled={loadingFeedback}>
              Try again
            </Button>
          )}
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default ScoreModal
