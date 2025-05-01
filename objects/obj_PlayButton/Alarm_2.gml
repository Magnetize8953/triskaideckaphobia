// alarm to delay death to after alarm 1 (networked bluff) finishes
if (alarm_1_running) {
    alarm[2] = 5;
} else {
    instance_destroy(self);
}