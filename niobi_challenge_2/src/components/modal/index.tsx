import styled, { keyframes } from "styled-components";
import { AppContext } from "../../context";
import { useContext } from "react";

const fadeIn = keyframes`
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
`;

const ModalOverlay = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  z-index: 40;
  display: flex;
  align-items: center;
  justify-content: center;
  animation: ${fadeIn} 0.3s ease-out;
`;

const ModalContainer = styled.div`
  width: 100%;
  max-width: 750px;
  background: #fff;
  border-radius: 16px;
`;

const ModalHeader = styled.div`
  position: relative;
  padding: 0;
  //
  border-radius: 16px;
`;

const CloseButton = styled.button`
  position: absolute;
  top: 16px;
  right: 16px;
  width: 32px;
  height: 32px;
  border: none;
  background: #f8f9fa;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  color: #6c757d;
  transition: all 0.2s ease;
  z-index: 50;

  &:hover {
    background: #e9ecef;
    color: #495057;
    transform: scale(1.1);
  }

  &:active {
    transform: scale(0.95);
  }

  &:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
  }
`;

const ModalContent = styled.div`
  padding: 0;
  max-width: 750px;

  width: 100%;
  box-sizing: border-box;
  background: #fff;
  border-radius: 16px;

  @media (max-width: 768px) {
    height: 100%;
  }
`;

const Modal = () => {
  const { modal, setModal, setShowModal } = useContext(AppContext);

  return (
    <ModalOverlay
      onClick={() => {
        setModal(null);
        setShowModal(false);
      }}
    >
      <ModalContainer onClick={(e) => e.stopPropagation()}>
        <ModalHeader>
          <CloseButton
            onClick={() => {
              setModal(null);
              setShowModal(false);
            }}
          >
            &times;
          </CloseButton>
        </ModalHeader>
        <ModalContent>{modal}</ModalContent>
      </ModalContainer>
    </ModalOverlay>
  );
};

export default Modal;
