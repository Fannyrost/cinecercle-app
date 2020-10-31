const openModal = () => {

  const button = document.querySelector('#open-modal');
  console.log(button)
  if (button === undefined)
    return
  button.addEventListener('click', (event) => {
    event.preventDefault();
    const form = document.querySelector('#modal-form');
    form.classList.remove('hidden');
  })
};


  export { openModal }
