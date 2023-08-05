import { Button, Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'

const LearningStyleModal = (args) => {
  const navigate = useNavigate()
  const { t } = useTranslation()
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
      <ModalHeader>{t('learning_style_quest')}</ModalHeader>
      <ModalBody>{t('learning_style_question')}</ModalBody>
      <ModalFooter>
        <div className="Modal-bottom" style={{ justifyContent: 'space-evenly' }}>
          <Button color="success" onClick={OnYes}>
            {t('yes')}
          </Button>
          <Button color="danger" onClick={OnNo}>
            {t('no')}
          </Button>
        </div>
      </ModalFooter>
    </Modal>
  )
}

export default LearningStyleModal
