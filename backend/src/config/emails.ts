

import {mailtrapClient, sender} from "./config";
import { WELCOME_EMAIL_TEMPLATE, RESERVATION_REQUEST_EMAIL_TEMPLATE, RESERVATION_ACCEPTED_EMAIL_TEMPLATE, RESERVATION_REJECTED_EMAIL_TEMPLATE} from "./template";


export const sendWelcomeEmail = async (email:string) => {
    const recipient = [{ email }];

    try {
        const response = await mailtrapClient.send({
            from: sender,
            to: recipient,
            subject: "Congratulations",
            html: WELCOME_EMAIL_TEMPLATE
        });
    } catch (error) {
        console.error(`Error sending welcome email`, error);
        throw new Error(`Error sending welcome email: ${error}`);
    }
};


export const sendReservationRequestDone = async (email:string, reservationDate: string,reservationTime: string,  ) => {
    const recipient = [{ email }];
    try {
        const response = await mailtrapClient.send({
            from: sender,
            to: recipient,
            subject: "Reservation Request Received",
            html: RESERVATION_REQUEST_EMAIL_TEMPLATE.replace("{reservationDate}", reservationDate).replace("{reservationTime}", reservationTime)
        });
    } catch (error) {
        console.error(`Error sending verification email`, error);
        throw new Error(`Error sending verification email: ${error}`);
    }
};

export const sendReservationAcceptedEmail = async (email:string,  reservationDate: string,reservationTime: string, ) => {
    const recipient = [{ email }];
    try {
        const response = await mailtrapClient.send({
            from: sender,
            to: recipient,
            subject: "Reservation Accepted",
            html: RESERVATION_ACCEPTED_EMAIL_TEMPLATE.replace("{reservationDate}", reservationDate).replace("{reservationTime}", reservationTime)
        });
    } catch (error) {
        console.error(`Error sending reservation accepted email`, error);
        throw new Error(`Error sending reservation accepted email: ${error}`);
    }
};

export const sendReservationRejectedEmail = async (email:string,  reservationDate: string,reservationTime: string, ) => {
    const recipient = [{ email }];
    try {
        const response = await mailtrapClient.send({
            from: sender,
            to: recipient,
            subject: "Reservation Rejected",
            html: RESERVATION_REJECTED_EMAIL_TEMPLATE.replace("{reservationDate}", reservationDate).replace("{reservationTime}", reservationTime)
        });
    } catch (error) {
        console.error(`Error sending reservation rejected email`, error);
        throw new Error(`Error sending reservation rejected email: ${error}`);
    }
};


