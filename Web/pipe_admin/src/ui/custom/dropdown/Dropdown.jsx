import React, { useState } from 'react';

const Dropdown = ({ options, onOptionSelect }) => {
  const [isOpen, setIsOpen] = useState(false);
  const [selectedOption, setSelectedOption] = useState(null);

  const handleClick = () => {
    setIsOpen(!isOpen);
  };

  const handleOptionSelected = (option) => {
    setSelectedOption(option);
    setIsOpen(false); // Close dropdown after selection
    onOptionSelect(option); // Call provided handler
  };

  return (
    <div className="dropdown">
      <button type="button" onClick={handleClick} className="dropdown-trigger">
        {selectedOption ? (
          <>
            <span className="dropdown-trigger-emoji">{selectedOption.emoji}</span>
            <span className="dropdown-trigger-title">{selectedOption.title}</span>
          </>
        ) : (
          // Display placeholder if no option selected
          <span>Select a Flag</span>
        )}
      </button>
      {isOpen && (
        <ul className="dropdown-menu">
          {options.map((option) => (
            <li key={option.emoji} onClick={() => handleOptionSelected(option)}>
              <span className="dropdown-menu-item-emoji">{option.emoji}</span>
              <span className="dropdown-menu-item-title">{option.title}</span>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default Dropdown;


