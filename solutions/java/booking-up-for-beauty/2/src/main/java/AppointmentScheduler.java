import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

class AppointmentScheduler {
    public LocalDateTime schedule(String appointmentDateDescription) {
	return LocalDateTime.parse(appointmentDateDescription, DateTimeFormatter.ofPattern("M/dd/yyyy HH:mm:ss"));
    }

    public boolean hasPassed(LocalDateTime appointmentDate) {
        return appointmentDate.isBefore(LocalDateTime.now());
    }

    public boolean isAfternoonAppointment(LocalDateTime appointmentDate) {
        return appointmentDate.toLocalTime().isAfter(LocalTime.of(11, 59, 59))
	    && appointmentDate.toLocalTime().isBefore(LocalTime.of(18, 00));
    }

    public String getDescription(LocalDateTime appointmentDate) {
        return "You have an appointment on " + appointmentDate.format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy")) + ", at " + appointmentDate.format(DateTimeFormatter.ofPattern("h:mm a")).toLowerCase();
    }

    public LocalDate getAnniversaryDate() {
        return LocalDate.now().withMonth(9).withDayOfMonth(15);
    }
}
