import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap'
import { useNavigate } from 'react-router-dom'

const LearningStyleModal = (args) => {
  const navigate = useNavigate()
  const { openModal, setOpenModal } = args

  const OnYes = () => {
    setOpenModal(false)
    navigate('/questionnaire')
  }

  const OnNo = () => {
    setOpenModal(false)
  }

  return (
    <Modal isOpen={openModal} centered>
      <ModalHeader>Learning Style</ModalHeader>
      <ModalBody>Do you want do Learning Style Questionnaire?</ModalBody>
      <ModalFooter>
        <div className="Modal-bottom" style={{ justifyContent: 'space-evenly' }}>
          <Button color="success" onClick={OnYes}>
            Yes
          </Button>
          <Button color="danger" onClick={OnNo}>
            No
          </Button>
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default LearningStyleModal
