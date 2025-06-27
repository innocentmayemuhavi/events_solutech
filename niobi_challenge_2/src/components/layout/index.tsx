import styled from "styled-components";
import RoundedButton from "../buttons/rounded-button";
import { useContext } from "react";
import { AppContext } from "../../context";
import TransferForm from "../forms/transfer-forms";
import Modal from "../modal";
import { useScreenSize } from "../../utils/get-screen-size";
import BottomNav from "../bottom-nav";
import Header from "../header";

const StyledLayout = styled.main`
  display: flex;
  flex-direction: column;
  margin: 0;
  padding: 0;
  .layout {
    &-children {
      max-width: 1200px;
      width: 100%;
      margin: 0 auto;
    }
    &-button {
      position: fixed;
      bottom: 12%;
      right: 15px;
      z-index: 2;

      @media (min-width: 751px) {
        right: 25px;
        bottom: 5%;
      }
    }
  }
`;

const Layout = ({ children }: { children: React.ReactNode }) => {
  const { setModal, setShowModal, showModal } = useContext(AppContext);
  const size = useScreenSize();
  return (
    <StyledLayout>
      <Header />
      <section className="layout-children">{children}</section>
      <div className="layout-button">
        {" "}
        <RoundedButton
          onClick={() => {
            setModal(<TransferForm />);
            setShowModal(true);
          }}
        >
          Add Transaction
        </RoundedButton>
      </div>
      {showModal && <Modal />}
      {size.width <= 750 && <BottomNav />}
    </StyledLayout>
  );
};

export default Layout;
