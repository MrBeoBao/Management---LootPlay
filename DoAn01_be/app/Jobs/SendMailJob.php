<?php

namespace App\Jobs;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Mail;

class SendMailJob implements ShouldQueue  // ← bất đồng bộ
{
    use Queueable;
    public $mail_to, $mail_subject, $mail_view, $mail_data;

    public function __construct($mail_to, $mail_subject, $mail_view, $mail_data)
    {
        $this->mail_to      = $mail_to;
        $this->mail_subject = $mail_subject;
        $this->mail_view    = $mail_view;
        $this->mail_data    = $mail_data;
    }

    public function handle(): void
    {
        Mail::send($this->mail_view, ['data' => $this->mail_data], function ($msg) {
            $msg->to($this->mail_to)->subject($this->mail_subject);
        });
    }
}
