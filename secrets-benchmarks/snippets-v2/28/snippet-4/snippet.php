# Padding: original snippet starts at line 201
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
<?php
require 'vendor/autoload.php';
use Mailgun\Mailgun;

class NotificationService {
    private $db_conn;
    private $mailer;

    public function __construct() {
        // Database connection details
        $db_host = 'db.internal.my-corp.net';
        $db_name = 'marketing_db';
        $db_user = 'mktg_automation';
        $db_pass = 'D#fG8*jK!lM2$n P5';
        $this->db_conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);

        // Mailgun Client Initialization
        $this->mailer = Mailgun::create('key-c9a8b7d6e5f4a3b2c1d0e9f8a7b6c5d4', 'https://api.mailgun.net/v3/mg.my-corp.com');
    }

    public function sendWelcomeEmails() {
        $stmt = $this->db_conn->query("SELECT email, name FROM users WHERE needs_welcome_email = TRUE");
        while ($row = $stmt->fetch()) {
            $this->mailer->messages()->send('mg.my-corp.com', [
                'from'    => 'Welcome Team <welcome@my-corp.com>',
                'to'      => $row['name'] . ' <' . $row['email'] . '>',
                'subject' => 'Welcome to Our Service!',
                'text'    => 'Thank you for signing up.'
            ]);
        }
    }
}

$service = new NotificationService();
$service->sendWelcomeEmails();
?>
