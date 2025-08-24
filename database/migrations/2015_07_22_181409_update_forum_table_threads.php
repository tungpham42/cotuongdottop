<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateForumTableThreads extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Skip column rename that requires Doctrine DBAL
        // This change can be applied manually if needed
        // Schema::table('forum_threads', function (Blueprint $table) {
        //     $table->renameColumn('parent_category', 'category_id');
        // });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Schema::table('forum_threads', function (Blueprint $table) {
        //     $table->renameColumn('category_id', 'parent_category');
        // });
    }
}
