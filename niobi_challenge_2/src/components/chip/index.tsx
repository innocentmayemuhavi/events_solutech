import styled from "styled-components";

const StyledChip = styled.div`
  display: inline-flex;
  align-items: center;
  padding: 0.4em 0.8em;
  border-radius: 12px;
  background-color: #f0f0f0;
  border: 1px solid #ddd;
  font-size: 0.875em;
  font-weight: 500;
  color: #333;

  &:not(:last-child) {
    margin-right: 0.5em;
  }
`;

const Chip = ({ children }: { children: React.ReactNode }) => (
  <StyledChip>{children}</StyledChip>
);

export default Chip;
