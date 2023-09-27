const baseUrl = 'http://127.0.0.1:3000';

//users endpoints

const createUserUrl = "$baseUrl/users"; // post method
const userLoginUrl = "$baseUrl/users/sign_in"; // post
const usersListUrl = "$baseUrl/users"; // get
var userById = "$baseUrl/users"; // get method with id params
const currentUserProfile = "$baseUrl/users/profile"; //get method

//messages endpoints

const messagesList = "$baseUrl/messages"; //get method with reciever_id param
const sendMessageUrl = "$baseUrl/send_message"; //post method
