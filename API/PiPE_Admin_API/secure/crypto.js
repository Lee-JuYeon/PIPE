import bcrypt from 'bcrypt'; // 전체 모듈을 import

const encrypt = async ( text ) => {
    const saltRounds = 10

    // salt 생성
    const salt = await bcrypt.genSalt(saltRounds)

    // hash
    const hashedText = await bcrypt.hash(text, salt)

    // return {
    //     salt: salt,
    //     hashedText: hashedText,
    // }
    return hashedText
}


async function compare(inputText, hashedText) { // async 사용
  try {
    const result = await bcrypt.compare(inputText, hashedText); // await 사용
    return result;
  } catch (err) {
    console.error('Error comparing passwords:', err);
    throw err; // 에러 던지기
  }
}

export { 
    encrypt, 
    compare 
}; 
