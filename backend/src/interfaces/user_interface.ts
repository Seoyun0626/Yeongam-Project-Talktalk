
export interface User {

    user_name: string;
    user_id: string;
    user_email: string;
    user_pw: string;
}

// export interface IUpdateProfile {
//     user?: string;
//     description?: string;
//     fullname?: string;
//     phone?: string;
// }

export interface IChangePassword {
    currentPassword: string;
    newPassword: string
}

// export interface INewFriend {
//     uidFriend: string
// }

// export interface IAcceptFollowerRequest {
//     uidFriend: string,
//     uidNotification: string
// }