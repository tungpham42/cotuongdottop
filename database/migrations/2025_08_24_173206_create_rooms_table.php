<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->string('name')->nullable();
            $table->string('player_turn')->nullable();
            $table->integer('host_id')->nullable();
            $table->integer('guest_id')->nullable();
            $table->integer('result')->nullable();
            $table->float('host_score')->default(0);
            $table->float('guest_score')->default(0);
            $table->float('host_elo')->default(0);
            $table->float('guest_elo')->default(0);
            $table->string('fen')->default('rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR r - - 0 1');
            $table->string('pass')->nullable();
            $table->bigInteger('host_time_remaining')->nullable();
            $table->bigInteger('guest_time_remaining')->nullable();
            $table->timestamp('modified_at')->useCurrent()->useCurrentOnUpdate();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('rooms');
    }
};
